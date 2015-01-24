//
//  MTRTimelineComponentView.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRTimelineComponentView.h"
#import "MTRColors.h"

@implementation MTRTimelineComponentView

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame type:(MTRComponentType)type {
    if ( (self = [super initWithFrame:frame]) != nil) {
        _componentType = type;
    }
    return self;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (void)setComponentType:(MTRComponentType)componentType {
    _componentType = componentType;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectangle1 = CGRectMake(0.0,(rect.size.height-rect.size.width)/2,rect.size.width,rect.size.width);
    CGContextBeginPath(context);
    CGContextSetFillColorWithColor(context, [MTRColors blue].CGColor);
    CGContextAddEllipseInRect(context, rectangle1);
    CGContextDrawPath(context, kCGPathFill);
    
    if (_componentType == MTRComponentTypeTop || _componentType == MTRComponentTypeMiddle) {
        
    }
}

@end
