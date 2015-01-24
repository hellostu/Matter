//
//  MTRApi.h
//  Matter
//
//  Created by Alex on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTRPost.h"

@interface MTRApi : NSObject

+ (instancetype)sharedInstance;

- (void)post:(MTRPost *)post withCompletion:(void (^)(MTRPost *))completion;

- (void)postsFromThisMonth:(void (^)(NSArray *))posts;

- (void)postsFromMonth:(NSInteger)monthIndex callback:(void (^)(NSArray *))posts;

- (void)postsWithMonthOffset:(NSInteger)monthOffset callback:(void (^)(NSArray *))posts;

- (void)listenToPost:(MTRPost *)post withDelegate:(id<MTRPostChangeDelegate>)delegate;

@end
