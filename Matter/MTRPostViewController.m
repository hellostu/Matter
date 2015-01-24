//
//  MTRPostViewController.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPostViewController.h"
#import "MTRColors.h"

@implementation MTRPostViewController

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)init {
    if ( ([super self]) != nil) {
        self.view.backgroundColor = [MTRColors lightCoolGrey];
    }
    return self;
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
