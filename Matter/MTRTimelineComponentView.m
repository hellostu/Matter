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
        self.opaque = NO;
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
    
    
    CGRect rectangle2 = CGRectZero;
    switch (_componentType) {
        case MTRComponentTypeTop:
            rectangle2 = CGRectMake(rect.size.width/4,rect.size.height/2,rect.size.width/2,rect.size.height/2);
            break;
        case MTRComponentTypeMiddle:
            rectangle2 = CGRectMake(rect.size.width/4,0.0,rect.size.width/2,rect.size.height);
            break;
        case MTRComponentTypeBottom:
            rectangle2 = CGRectMake(rect.size.width/4,0.0,rect.size.width/2,rect.size.height/2);
            break;
        default:
            break;
    }
    CGContextBeginPath(context);
    CGContextSetFillColorWithColor(context, [MTRColors blue].CGColor);
    CGContextAddRect(context,rectangle2);
    CGContextFillRect(context, rectangle2);
    CGContextDrawPath(context, kCGPathFill);
}

@end
