//
//  ViewController.m
//  Matter
//
//  Created by Stuart Lynch on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRRootViewController.h"
#import "MTRPostCreationView.h"
#import "MTRApi.h"
#import "MTRPost.h"

#define PADDING_LEFT 10
#define PADDING_RIGHT 10
#define PADDING_TOP 20

@interface MTRRootViewController () <MTRPostCreationViewDelegate> {
    MTRPostCreationView *_postCreationView;
}
@end

@implementation MTRRootViewController

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _postCreationView = [[MTRPostCreationView alloc] init];
    _postCreationView.translatesAutoresizingMaskIntoConstraints = NO;
    _postCreationView.delegate = self;
    [self.view addSubview:_postCreationView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_postCreationView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:PADDING_LEFT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_postCreationView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-PADDING_RIGHT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_postCreationView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:PADDING_TOP]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_postCreationView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:200.0]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark MTRCreationViewDelegate
//////////////////////////////////////////////////////////////////////////

- (void)postCreationViewDidPostWithTitle:(NSString *)title description:(NSString *)description {
    MTRPost *post = [[MTRPost alloc] initWithTitle:title description:description];
    [[MTRApi sharedInstance] post:post];
}

@end
