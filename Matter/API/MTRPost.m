//
//  MTRPost.m
//  Matter
//
//  Created by Alex on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPost.h"

@implementation MTRPost

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)body
{
    self = [super init];
    if (self) {
        _postDate = [NSDate date];
        _title = title;
        _body = body;
    }
    return self;
}

@end
