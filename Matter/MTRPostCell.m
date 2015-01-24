//
//  MTRPostCell.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPostCell.h"

#define LEFT_PADDING 10
#define RIGHT_PADDING 10
#define TOP_PADDING 15
#define BOTTOM_PADDING 15

@interface MTRPostCell () {
    MTRTimelineComponentView *_timelineComponent;
    UILabel *_titleLabel;
    UILabel *_descriptionLabel;
}
@end

@implementation MTRPostCell
@dynamic descriptionText;
@dynamic titleText;

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ( ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) != nil) {
        
        _timelineComponent = [[MTRTimelineComponentView alloc] initWithFrame:CGRectZero type:MTRComponentTypeTop];
        _timelineComponent.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_timelineComponent];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_timelineComponent
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:0.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_timelineComponent
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeLeft
                                                                    multiplier:1.0
                                                                      constant:5.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_timelineComponent
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:0.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_timelineComponent
                                                                     attribute:NSLayoutAttributeWidth
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeWidth
                                                                    multiplier:0.0
                                                                      constant:20.0]];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        
        [self.contentView addSubview:_titleLabel];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:TOP_PADDING]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:_timelineComponent
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:10.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:-RIGHT_PADDING]];
        
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:_descriptionLabel];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:_titleLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:10.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                     attribute:NSLayoutAttributeLeft
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:_timelineComponent
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:LEFT_PADDING]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                     attribute:NSLayoutAttributeBottom
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:-10.0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel
                                                                     attribute:NSLayoutAttributeRight
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeRight
                                                                    multiplier:1.0
                                                                      constant:-RIGHT_PADDING]];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _descriptionLabel.preferredMaxLayoutWidth = self.frame.size.width;
    [self layoutIfNeeded];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties
//////////////////////////////////////////////////////////////////////////

- (NSString *)titleText {
    return _titleLabel.text;
}

- (void)setTitleText:(NSString *)titleText {
    _titleLabel.text = titleText;
    [self layoutIfNeeded];
}

- (NSString *)descriptionText {
    return _descriptionLabel.text;
}

- (void)setDescriptionText:(NSString *)descriptionText {
    _descriptionLabel.text = descriptionText;
    [self layoutIfNeeded];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (void)setComponentType:(MTRComponentType)componentType {
    _timelineComponent.componentType = componentType;
}

@end
