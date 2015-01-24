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
#import "MTRColors.h"

#define PADDING_LEFT 10
#define PADDING_RIGHT 10
#define PADDING_TOP 20

@interface MTRRootViewController () <MTRPostCreationViewDelegate> {
    UITableView *_tableView;
}
@end

@implementation MTRRootViewController

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_tableView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    UIView *postBar = [[UIView alloc] init];
    postBar.translatesAutoresizingMaskIntoConstraints = NO;
    postBar.backgroundColor = [MTRColors blue];
    [self.view addSubview:postBar];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postBar
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_tableView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postBar
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postBar
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postBar
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:44.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postBar
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
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
