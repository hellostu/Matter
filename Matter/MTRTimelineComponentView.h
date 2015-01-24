//
//  MTRTimelineComponentView.h
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MTRComponentTypeTop,
    MTRComponentTypeMiddle,
    MTRComponentTypeBottom,
} MTRComponentType;

@interface MTRTimelineComponentView : UIView

@property(nonatomic, readwrite) MTRComponentType componentType;

- (id)initWithFrame:(CGRect)frame type:(MTRComponentType)type;

@end
