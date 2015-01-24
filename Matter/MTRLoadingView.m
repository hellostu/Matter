//
//  MTRLoadingView.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRLoadingView.h"
#import "MTRColors.h"

@implementation MTRLoadingView {
    UIActivityIndicatorView *_activityIndicatorView;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    if ( ([super initWithFrame:frame]) != nil) {
        self.backgroundColor = [MTRColors darkCoolGreyWithAlpha:0.5];
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_activityIndicatorView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicatorView
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                          constant:0.0]];
         [self addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicatorView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
        self.alpha = 0.0f;
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (void)startLoading {
    [_activityIndicatorView startAnimating];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0;
    }];
}

- (void)stopLoading {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [_activityIndicatorView stopAnimating];
    }];
}

@end
