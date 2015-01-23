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

- (void)post:(MTRPost *)post
{
    DBError *error = nil;
    NSString *fileName = [NSString stringWithFormat:@"%@/text.txt", [self pathForPost:post]];
    DBPath *dbPath = [[DBPath root] childPath:fileName];
    DBFile *file = [self.filesystem createFile:dbPath error:&error];
    if (file) {
        NSString *text = [NSString stringWithFormat:@"%@\n\n%@", post.title, post.body];
        [file writeString:text error:&error];
    }
}

- (NSString *)pathForPost:(MTRPost *)post
{
    NSCalendar *calendar = [NSCalendar new];
    NSDateComponents *component = [calendar components:0 fromDate:post.postDate];
    NSString *year = [NSString stringWithFormat:@"%ld", (long)[component year]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-YYYY HH:mm"];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *month = [formatter stringFromDate:post.postDate];
    [formatter setDateFormat:@"dd-HH:mm"];
    NSString *folder = [formatter stringFromDate:post.postDate];
    return [NSString stringWithFormat:@"%@/%@/%@/", year, month, folder];
}

@end
