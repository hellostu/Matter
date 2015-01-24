//
//  MCTransitionContainer.h
//  Mixcloud
//
//  This is a container class which simply holds one view controller. The class
//  can handle the transitional animation from one view controller to the other.
//  Used when the user logs in and out of the app, since the log in functionality
//  won't be part of the main navigation stack. 
//
//  Created by Stuart Lynch on 13/11/2012.
//  Copyright (c) 2012 Stuart Lynch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTRTransitionContainer;
@protocol MCTransitionContainerDelegate;

@interface MTRTransitionContainer : UIViewController

@property(weak, nonatomic, readonly) UIViewController *currentViewController;
@property(nonatomic, readwrite, weak) id<MCTransitionContainerDelegate> delegate;
- (id)initWithViewController:(UIViewController *)vc;

/**
 * Method to animate from one view controller to another. 
 *
 *      @param vc               View controller to transition to.
 *
 *      @param animationOption  The transition animation to be displayed when the controllers transition.
 *
 */
- (void)transitionToViewController:(UIViewController *)vc withAnimation:(UIViewAnimationOptions)animationOption;

@end

@protocol MCTransitionContainerDelegate <NSObject>

@optional
- (void)transitionContrainer:(MTRTransitionContainer *)transitionContainer willTransitionToViewController:(UIViewController *)to fromViewController:(UIViewController *)from;
- (void)transitionContrainer:(MTRTransitionContainer *)transitionContainer didTransitionToViewController:(UIViewController *)viewController;

@end