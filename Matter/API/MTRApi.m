//
//  MTRApi.m
//  Matter
//
//  Created by Alex on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRApi.h"
#import <Dropbox/Dropbox.h>

@interface MTRApi ()

@property (nonatomic, readonly) DBFilesystem *filesystem;

@end

@implementation MTRApi

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

+ (instancetype)sharedInstance
{
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        DBAccount *account = [[DBAccountManager sharedManager] linkedAccount] ;
        _filesystem = [[DBFilesystem alloc] initWithAccount:account];
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (void)post:(MTRPost *)post withCompletion:(void (^)(MTRPost *))completion
{
    DBError *error = nil;
    NSString *fileName = [NSString stringWithFormat:@"%@/text.txt", [self pathForPost:post]];
    DBPath *dbPath = [[DBPath root] childPath:fileName];
    DBFile *file = [self.filesystem createFile:dbPath error:&error];
    if (file) {
        NSString *text = [NSString stringWithFormat:@"%@\n\n%@", post.title, post.body];
        [file writeString:text error:&error];
        completion(post);
    }
}

- (NSString *)pathForPost:(MTRPost *)post
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"YYYY"];
    NSString *year = [formatter stringFromDate:post.postDate];
    [formatter setDateFormat:@"MM-MMMM"];
    NSString *month = [formatter stringFromDate:post.postDate];
    [formatter setDateFormat:@"dd-HH:mm"];
    NSString *folder = [formatter stringFromDate:post.postDate];
    return [NSString stringWithFormat:@"%@/%@/%@/", year, month, folder];
}

- (void)postsFromThisMonth:(void (^)(NSArray *))posts
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSDate *now = [NSDate new];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        [formatter setDateFormat:@"YYYY"];
        NSString *year = [formatter stringFromDate:now];
        [formatter setDateFormat:@"MM-MMMM"];
        NSString *month = [formatter stringFromDate:now];
        
        DBError *error = nil;
        NSString *path = [NSString stringWithFormat:@"%@/%@/", year, month];
        NSArray *fileInfos = [_filesystem listFolder:[[DBPath root] childPath:path] error:&error];
        
        NSMutableArray *postsArray = [NSMutableArray new];
        
        for (DBFileInfo *info in fileInfos) {
            DBPath *textPath = [info.path childPath:@"text.txt"];
            DBFile *file = [self.filesystem openFile:textPath error:&error];
            NSString *fileAsString = [file readString:&error];
            [file close];
            NSArray *splitFile = [fileAsString componentsSeparatedByString:@"\n\n"];
            [postsArray addObject:[[MTRPost alloc] initWithTitle:splitFile[0] description:splitFile[1]]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            posts([NSArray arrayWithArray:postsArray]);
        });
        
    });
}

@end
