//
//  MTRPost.m
//  Matter
//
//  Created by Alex on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPost.h"
#import "MTRDropboxLoader.h"

@interface MTRPost ()

@property (nonatomic, readonly) NSArray *images;
@property (nonatomic, readonly) NSArray *imageUrls;
@property (nonatomic, readonly) MTRDropboxLoader *imageLoader;

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

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)body imageUrls:(NSArray *)imageUrls imageLoader:(MTRDropboxLoader *)loader
{
    self = [super init];
    if (self) {
        _postDate = [NSDate date];
        _title = title;
        _body = body;
        _imageUrls = [NSArray arrayWithArray:imageUrls];
        _imageLoader = loader;
    }
    return self;
}

- (NSArray *)retreiveImages
{
    if (self.images) {
        return self.images;
    } else if ([self.imageUrls count] > 0) {
        return [self.imageLoader load:self.imageUrls];
    } else {
        return nil;
    }
}

@end
