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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Text file
        DBError *textError = nil;
        NSString *fileName = [NSString stringWithFormat:@"%@/text.txt", [self pathForPost:post]];
        DBPath *dbPath = [[DBPath root] childPath:fileName];
        DBFile *file = [self.filesystem createFile:dbPath error:&textError];
        if (file) {
            NSString *text = [NSString stringWithFormat:@"%@\n\n%@", post.title, post.body];
            [file writeString:text error:&textError];
        }
        
        // Images
        DBError *imageError = nil;
        NSInteger imagesLength = post.images.count;
        for (int i = 0; i < imagesLength; i++) {
            NSString *imageFilePath = [NSString stringWithFormat:@"%@/%d.png", [self pathForPost:post], i];
            DBPath *dbImagePath = [[DBPath root] childPath:imageFilePath];
            DBFile *file = [self.filesystem createFile:dbImagePath error:&imageError];
            if (file) {
                NSData *imageData = UIImagePNGRepresentation(post.images[i]);
                [file writeData:imageData error:&imageError];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(post);
        });
    });
    
}

- (NSString *)pathForPost:(MTRPost *)post
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"YYYY"];
    NSString *year = [formatter stringFromDate:post.postDate];
    [formatter setDateFormat:@"MM-MMMM"];
    NSString *month = [formatter stringFromDate:post.postDate];
    [formatter setDateFormat:@"dd HH-mm-ss"];
    NSString *folder = [formatter stringFromDate:post.postDate];
    return [NSString stringWithFormat:@"%@/%@/%@/", year, month, folder];
}

- (void)postsFromThisMonth:(void (^)(NSArray *))posts
{
    [self postsFromMonthOfDate:[NSDate new] callback:posts];
}

- (NSString *)pathForPostWithDate:(NSDate *)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"YYYY"];
    NSString *year = [formatter stringFromDate:date];
    [formatter setDateFormat:@"MM-MMMM"];
    NSString *month = [formatter stringFromDate:date];
    
    return [NSString stringWithFormat:@"%@/%@/", year, month];
}

- (void)postsFromMonth:(NSInteger)monthIndex callback:(void (^)(NSArray *))posts
{
    NSDate *date = [NSDate new];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = monthIndex;
    date = [[NSCalendar currentCalendar] dateBySettingUnit:NSCalendarUnitMonth value:monthIndex ofDate:date options:0];
    
    [self postsFromMonthOfDate:date callback:posts];
}

- (void)postsFromMonthOfDate:(NSDate *)date callback:(void (^)(NSArray *))posts
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *path = [self pathForPostWithDate:date];
        
        DBError *error = nil;
        NSArray *fileInfos = [_filesystem listFolder:[[DBPath root] childPath:path] error:&error];
        
        NSMutableArray *postsArray = [NSMutableArray new];
        
        for (DBFileInfo *info in fileInfos) {
            DBPath *textPath = [info.path childPath:@"text.txt"];
            DBFile *file = [self.filesystem openFile:textPath error:&error];
            NSString *fileAsString = [file readString:&error];
            [file close];
            NSArray *splitFile = [fileAsString componentsSeparatedByString:@"\n\n"];
            [postsArray addObject:[[MTRPost alloc] initWithTitle:splitFile[0] description:splitFile[1] images:nil]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            posts([NSArray arrayWithArray:postsArray]);
        });
        
    });
    
}

- (void)postsWithMonthOffset:(NSInteger)monthOffset callback:(void (^)(NSArray *))posts
{
    NSDate *date = [NSDate new];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = monthOffset;
    date = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
    [self postsFromMonthOfDate:date callback:posts];
}

@end
