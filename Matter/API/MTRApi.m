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
    DBPath *dbPath = [[DBPath root] childPath:@"hello.txt"];
    DBFile *file = [self.filesystem createFile:dbPath error:&error];
    if (file) {
        [file writeString:@"test!" error:&error];
    }
}

@end
