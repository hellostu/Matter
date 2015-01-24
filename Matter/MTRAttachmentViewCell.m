//
//  MTRAttachmentViewCell.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRAttachmentViewCell.h"
#import "MTRColors.h"

@implementation MTRAttachmentViewCell

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    if ( (self = [super initWithFrame:frame]) != nil) {
        self.backgroundColor = [MTRColors white];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:4.0f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0
                                                          constant:4.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0
                                                          constant:-4.0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:-4.0]];
    }
    return self;
}

@end
