//
//  MTRPost.m
//  Matter
//
//  Created by Alex on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPost.h"
#import "MTRDropboxLoader.h"
#import "MTRApi.h"

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

- (instancetype)initWithDate:(NSDate *)date title:(NSString *)title description:(NSString *)body imageUrls:(NSArray *)imageUrls imageLoader:(MTRDropboxLoader *)loader
{
    self = [super init];
    if (self) {
        _postDate = date;
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

- (void)retreiveImages:(void (^)(NSArray *))imageHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *images = [self retreiveImages];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageHandler(images);
        });
    });
}

- (void)listen:(id<MTRPostChangeDelegate>)delegate
{
    [[MTRApi sharedInstance] listenToPost:self withDelegate:delegate];
}

@end
