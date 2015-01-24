//
//  MTRPost.m
//  Matter
//
//  Created by Alex on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPost.h"

@interface MTRPost ()

@property (nonatomic, readonly) NSArray *images;
@property (nonatomic, readonly) NSArray *imageUrls;

@end

@implementation MTRPost

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)body images:(NSArray *)images
{
    self = [super init];
    if (self) {
        _postDate = [NSDate date];
        _title = title;
        _body = body;
        _images = [NSArray arrayWithArray:images];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)body imageUrls:(NSArray *)imageUrls
{
    self = [super init];
    if (self) {
        _postDate = [NSDate date];
        _title = title;
        _body = body;
        _imageUrls = [NSArray arrayWithArray:imageUrls];
    }
    return self;
}

- (NSArray *)retreiveImages
{
    if (self.images) {
        return self.images;
    } else if ([self.imageUrls count] > 0) {
        //TODO
        return nil;
    } else {
        return nil;
    }
}

@end
