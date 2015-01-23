//
//  MTRPostCreationView.m
//  Matter
//
//  Created by Stuart Lynch on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPostCreationView.h"

#define PADDING_LEFT 10
#define PADDING_RIGHT 10
#define PADDING_TOP 10
#define PADDING_BOTTOM 10

@interface MTRPostCreationView () {
    UILabel     *_titleLabel;
    UITextField *_titleTextField;
    UILabel     *_descriptionLabel;
    UITextView  *_descriptionTextView;
    UIButton    *_postButton;
}

@end

@implementation MTRPostCreationView

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    
    if( (self =[super initWithFrame:frame]) != nil) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.text = @"Title:";
        [self addSubview:_titleLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:PADDING_TOP]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0
                                                          constant:PADDING_LEFT]];
        
        _titleTextField = [[UITextField alloc] init];
        _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
        _titleTextField.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_titleTextField];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleTextField
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_titleLabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:10.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleTextField
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0
                                                          constant:PADDING_LEFT]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleTextField
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0
                                                          constant:-PADDING_RIGHT]];
        
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _descriptionLabel.text = @"Description:";
        [self addSubview:_descriptionLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_titleTextField
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:10.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0
                                                          constant:PADDING_LEFT]];
        
        _descriptionTextView = [[UITextView alloc] init];
        _descriptionTextView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_descriptionTextView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_descriptionLabel
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:10.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0
                                                          constant:PADDING_LEFT]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0
                                                          constant:-PADDING_RIGHT]];
        
        _postButton = [[UIButton alloc] init];
        _postButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_postButton setTitle:@"Post" forState:UIControlStateNormal];
        [_postButton addTarget:self action:@selector(postButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_postButton];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_postButton
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_descriptionTextView
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:10.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_postButton
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0
                                                          constant:PADDING_LEFT]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_postButton
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0
                                                          constant:-PADDING_RIGHT]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_postButton
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:0.0
                                                          constant:30.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_postButton
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:-PADDING_BOTTOM]];
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Actions
//////////////////////////////////////////////////////////////////////////

- (void)postButtonPressed {
    [self.delegate postCreationViewDidPostWithTitle:_titleTextField.text description:_descriptionTextView.text];
}

@end
