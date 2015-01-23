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

+ (instancetype) sharedApi
{
    static dispatch_once_t pred;
    static id sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init
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
    
}

@end
