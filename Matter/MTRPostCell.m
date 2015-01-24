//
//  MTRPostCell.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPostCell.h"

@interface MTRPostCell () {
    MTRTimelineComponentView *_timelineComponent;
}
@end

@implementation MTRPostCell

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
        
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (void)setComponentType:(MTRComponentType)componentType {
    _timelineComponent.componentType = componentType;
}

@end
