//
//  MTRPostCell.h
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTRTimelineComponentView.h"

@interface MTRPostCell : UITableViewCell

@property(nonatomic, readwrite) MTRComponentType componentType;
@property(nonatomic, strong) NSString   *titleText;
@property(nonatomic, strong) NSString   *descriptionText;
@property(nonatomic, readwrite) BOOL    showImages;
@property(nonatomic, strong) UIImage    *image;

- (void)setDate:(NSDate *)date;

@end
