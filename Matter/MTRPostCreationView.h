//
//  MTRPostCreationView.h
//  Matter
//
//  Created by Stuart Lynch on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTRPostCreationView;
@protocol MTRPostCreationViewDelegate;

@interface MTRPostCreationView : UIView

@property(nonatomic, weak) id<MTRPostCreationViewDelegate>delegate;

@end

@protocol MTRPostCreationViewDelegate <NSObject>

-(void)postCreationViewDidPostWithTitle:(NSString *)title description:(NSString *)description;

@end