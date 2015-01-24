//
//  MTRPostViewController.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPostViewController.h"
#import "MTRColors.h"

#define PADDING_LEFT 10
#define PADDING_RIGHT 10
#define PADDING_TOP 20

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
        
        UITextField *titleTextField = [[UITextField alloc] init];
        titleTextField.translatesAutoresizingMaskIntoConstraints = NO;
        titleTextField.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:titleTextField];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:titleLabel
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:10.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:PADDING_LEFT]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleTextField
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
                                                                 toItem:titleTextField
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
        
        UITextView *descriptionTextView = [[UITextView alloc] init];
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:descriptionTextView];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionTextView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:descriptionLabel
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:10.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionTextView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:PADDING_LEFT]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionTextView
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:-PADDING_RIGHT]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionTextView
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:0.0
                                                              constant:80.0f]];
        
        UIButton *postButton = [[UIButton alloc] init];
        
    }
    return self;
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
