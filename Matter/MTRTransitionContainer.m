//
//  MCTransitionContainer.m
//  Mixcloud
//
//  Created by Stuart Lynch on 13/11/2012.
//  Copyright (c) 2012 Stuart Lynch. All rights reserved.
//

#import "MTRTransitionContainer.h"

@interface MTRTransitionContainer ()
{
    NSMutableArray *_constraints;
}
@end

@implementation MTRTransitionContainer

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)initWithViewController:(UIViewController *)vc
{
    if ( (self = [super init]) != nil)
    {
        _currentViewController = vc;
        _constraints = [[NSMutableArray alloc] initWithCapacity:4];
        [self addChildViewController:vc];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *currentViewControllerView = _currentViewController.view;
    [currentViewControllerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:currentViewControllerView];
    [_constraints addObject:[NSLayoutConstraint constraintWithItem:currentViewControllerView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
     [_constraints addObject:[NSLayoutConstraint constraintWithItem:currentViewControllerView
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1.0
                                                            constant:0.0]];
    [_constraints addObject:[NSLayoutConstraint constraintWithItem:currentViewControllerView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [_constraints addObject:[NSLayoutConstraint constraintWithItem:currentViewControllerView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraints:_constraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Properties
//////////////////////////////////////////////////////////////////////////

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return _currentViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return _currentViewController;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (NSString *)title {
    return _currentViewController.title;
}

- (void)transitionToViewController:(UIViewController *)vc withAnimation:(UIViewAnimationOptions)animationOption
{
    if ([self.delegate respondsToSelector:@selector(transitionContrainer:willTransitionToViewController:fromViewController:)])
    {
        [self.delegate transitionContrainer:self willTransitionToViewController:vc fromViewController:_currentViewController];
    }
    [self addChildViewController:vc];
    [vc willMoveToParentViewController:self];
    [_currentViewController willMoveToParentViewController:nil];
    [self transitionFromViewController:_currentViewController
                      toViewController:vc
                              duration:0.5
                               options:animationOption
                            animations:^{} completion:^(BOOL finished)
     {
         [_currentViewController removeFromParentViewController];
         [vc didMoveToParentViewController:self];
         _currentViewController = vc;
         if ([self.delegate respondsToSelector:@selector(transitionContrainer:didTransitionToViewController:)])
         {
             [self.delegate transitionContrainer:self didTransitionToViewController:_currentViewController];
         }
     }];
    
    UIView *currentViewControllerView = vc.view;
    [currentViewControllerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view removeConstraints:_constraints];
    [_constraints removeAllObjects];
    [_constraints addObject:[NSLayoutConstraint constraintWithItem:currentViewControllerView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:0.0]];
    [_constraints addObject:[NSLayoutConstraint constraintWithItem:currentViewControllerView
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1.0
                                                          constant:0.0]];
    [_constraints addObject:[NSLayoutConstraint constraintWithItem:currentViewControllerView
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1.0
                                                          constant:0.0]];
    [_constraints addObject:[NSLayoutConstraint constraintWithItem:currentViewControllerView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:0.0]];
    [self.view addConstraints:_constraints];
}

@end
