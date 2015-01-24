//
//  MTRConstants.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRColors.h"

@implementation MTRColors

+ (UIColor *)blue {
    return [UIColor colorWithRed:0.0 green:0.494 blue:0.898 alpha:1.0];
}
+ (UIColor *)white {
    return [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}
+ (UIColor *)lighterCoolGrey {
    return [UIColor colorWithRed:0.482 green:0.537 blue:0.58 alpha:1.0];
}
+ (UIColor *)lightCoolGrey {
    return [UIColor colorWithRed:0.278 green:0.322 blue:0.365 alpha:1.0];
}
+ (UIColor *)darkCoolGreyWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:0.239 green:0.275 blue:0.302 alpha:alpha];
}


@end
