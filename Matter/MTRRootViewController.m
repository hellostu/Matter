//
//  ViewController.m
//  Matter
//
//  Created by Stuart Lynch on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRRootViewController.h"
#import "MTRPostViewController.h"
#import "MTRPostCreationView.h"
#import "MTRApi.h"
#import "MTRPost.h"
#import "MTRColors.h"
#import "MTRPostCell.h"

#define PADDING_LEFT 10
#define PADDING_RIGHT 10
#define PADDING_TOP 20

@interface MTRRootViewController () <UITableViewDataSource> {
    UITableView *_tableView;
    NSArray *_posts;
}
@end

@implementation MTRRootViewController

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)init {
    if ( (self = [super init]) != nil) {
        self.title = @"Matter";
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44.0f;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchFromDropbox];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[MTRPostCell class] forCellReuseIdentifier:@"postCell"];
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
    postBar.userInteractionEnabled = YES;
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
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postBarTapped:)];
    [postBar addGestureRecognizer:tapGesture];
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITableViewDataSource
//////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTRPostCell *postCell = [tableView dequeueReusableCellWithIdentifier:@"postCell"];
    MTRPost *post = _posts[indexPath.row];
    postCell.titleText = post.title;
    postCell.descriptionText = post.body;
    if (indexPath.row == 0) {
        postCell.componentType = MTRComponentTypeTop;
    } else if(indexPath.row == _posts.count-1) {
        postCell.componentType = MTRComponentTypeBottom;
    } else {
        postCell.componentType = MTRComponentTypeMiddle;
    }
    [post retreiveImages:^(NSArray *images) {
        if (images != nil && images.count > 0) {
            postCell.image = images[0];
        }
    }];
    
    return postCell;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Action
//////////////////////////////////////////////////////////////////////////

- (void)postBarTapped:(UITapGestureRecognizer *)tapGesture {
    MTRPostViewController *postViewController = [[MTRPostViewController alloc] init];
    [self presentViewController:postViewController animated:YES completion:nil];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (void)fetchFromDropbox {
    [[MTRApi sharedInstance] postsFromThisMonth:^(NSArray *posts) {
        _posts = posts;
        [_tableView reloadData];
    }];
}

@end
