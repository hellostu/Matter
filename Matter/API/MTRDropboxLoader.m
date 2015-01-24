//
//  MTRDropboxLoader.m
//  Matter
//
//  Created by Alex on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRDropboxLoader.h"

@interface MTRDropboxLoader ()

@property (nonatomic, strong) DBFilesystem *filesystem;

@end

@implementation MTRDropboxLoader

- (instancetype)initWithFilesystem:(DBFilesystem *)filesystem
{
    self = [super init];
    if (self) {
        _filesystem = filesystem;
    }
    return self;
}

- (NSArray *)load:(NSArray *)dbObjects
{
    NSMutableArray *uiImageArray = [NSMutableArray new];
    for (DBFileInfo *fileInfo in dbObjects) {
        DBFile *file = [self.filesystem openFile:fileInfo.path error:nil];
        NSData *data = [file readData:nil];
        UIImage *image = [UIImage imageWithData:data];
        [uiImageArray addObject:image];
        [file close];
    }
    return uiImageArray;
}

@end
