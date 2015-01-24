//
//  MTRPostViewController.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPostViewController.h"
#import "MTRColors.h"
#import "MTRLoadingView.h"
#import "MTRApi.h"
#import "MTRPost.h"

#define PADDING_LEFT 10
#define PADDING_RIGHT 10
#define PADDING_TOP 20

@interface MTRPostViewController () {
    MTRLoadingView *_loadingView;
    UITextField *_titleTextField;
    UITextView *_descriptionTextView;
}
@end

@implementation MTRPostViewController

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)init {
    if ( ([super self]) != nil) {
        self.view.backgroundColor = [MTRColors lightCoolGrey];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"Title:";
        titleLabel.textColor = [MTRColors white];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:titleLabel];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:PADDING_TOP]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:PADDING_LEFT]];
        
        _titleTextField = [[UITextField alloc] init];
        _titleTextField.translatesAutoresizingMaskIntoConstraints = NO;
        _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:_titleTextField];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_titleTextField
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:titleLabel
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:10.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_titleTextField
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:PADDING_LEFT]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_titleTextField
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:-PADDING_RIGHT]];
        
        UILabel *descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        descriptionLabel.textColor = [MTRColors white];
        descriptionLabel.text = @"Description:";
        [self.view addSubview:descriptionLabel];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_titleTextField
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:10.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:PADDING_LEFT]];
        
        _descriptionTextView = [[UITextView alloc] init];
        _descriptionTextView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_descriptionTextView];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:descriptionLabel
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:10.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:PADDING_LEFT]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:-PADDING_RIGHT]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:0.0
                                                              constant:80.0f]];
        
        UIButton *postButton = [[UIButton alloc] init];
        postButton.translatesAutoresizingMaskIntoConstraints = NO;
        [postButton setTitle:@"POST" forState:UIControlStateNormal];
        [postButton addTarget:self action:@selector(postButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:postButton];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postButton
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:_descriptionTextView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:10.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postButton
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:PADDING_LEFT]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postButton
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:-PADDING_RIGHT]];
        
        
        _loadingView = [[MTRLoadingView alloc] init];
        _loadingView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_loadingView];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loadingView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loadingView
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loadingView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loadingView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0]];
    }
    return self;
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Actions
//////////////////////////////////////////////////////////////////////////

- (void)postButtonPressed {
    MTRPost *post = [[MTRPost alloc] initWithTitle:_titleTextField.text description:_descriptionTextView.text images:nil];
    [_loadingView startLoading];
    [[MTRApi sharedInstance] post:post withCompletion:^(MTRPost *post) {
        [_loadingView stopLoading];
    }];
}

@end
