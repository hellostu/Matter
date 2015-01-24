//
//  MTRLoginViewController.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRLoginViewController.h"
#import <Dropbox/Dropbox.h>

@implementation MTRLoginViewController

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)init {
    if ( (self = [super init]) != nil) {
        self.title = @"Welcome to Matter";
        
        UIView *wrapperView = [[UIView alloc] init];
        wrapperView.translatesAutoresizingMaskIntoConstraints = NO;
        wrapperView.userInteractionEnabled = YES;
        [self.view addSubview:wrapperView];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:wrapperView
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:wrapperView
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1.0
                                                               constant:20.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:wrapperView
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:0.0
                                                               constant:230.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:wrapperView
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:0.0
                                                               constant:230.0]];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginWithDropboxTapped:)];
        [wrapperView addGestureRecognizer:tapGesture];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropbox_icon.png"]];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [wrapperView addSubview:imageView];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:wrapperView
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:wrapperView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        UIButton *loginWithDropboxButton = [[UIButton alloc] init];
        loginWithDropboxButton.translatesAutoresizingMaskIntoConstraints = NO;
        [loginWithDropboxButton setTitle:@"Login with Dropbox" forState:UIControlStateNormal];
        [loginWithDropboxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [wrapperView addSubview:loginWithDropboxButton];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:loginWithDropboxButton
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:wrapperView
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:loginWithDropboxButton
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:wrapperView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0]];
        
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Actions
//////////////////////////////////////////////////////////////////////////

- (void)loginWithDropboxTapped:(UITapGestureRecognizer *)tapGesture {
    [[DBAccountManager sharedManager] linkFromController:self];
}

@end
