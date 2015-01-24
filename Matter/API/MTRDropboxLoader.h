//
//  MTRDropboxLoader.h
//  Matter
//
//  Created by Alex on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Dropbox/Dropbox.h>

@interface MTRDropboxLoader : NSObject

- (instancetype)initWithFilesystem:(DBFilesystem *)filesystem;

- (NSArray *)load:(NSArray *)dbObjects;

@end
