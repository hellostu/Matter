//
//  MTRPostViewController.m
//  Matter
//
//  Created by Stuart Lynch on 24/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "MTRPostViewController.h"
#import "MTRColors.h"
#import "MTRLoadingView.h"
#import "MTRApi.h"
#import "MTRPost.h"
#import "MTRAttachmentViewCell.h"

#define PADDING_LEFT 10
#define PADDING_RIGHT 10
#define PADDING_TOP 20
#define PADDING_BOTTOM 0

@interface MTRPostViewController () <UIImagePickerControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate>{
    MTRLoadingView *_loadingView;
    UITextField                 *_titleTextField;
    UITextView                  *_descriptionTextView;
    UICollectionView            *_collectionView;
    UICollectionViewFlowLayout  *_flowLayout;
    
    UIToolbar                   *_doneBar;
    NSLayoutConstraint          *_doneBarTopConstraint;
    
    CGSize                      _keyboardSize;
    
    NSMutableArray              *_attachments;
}
@end

@implementation MTRPostViewController

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (id)init {
    if ( ([super self]) != nil) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        _attachments = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [MTRColors lightCoolGrey];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"Title:";
    titleLabel.textColor = [MTRColors white];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:PADDING_TOP]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:PADDING_LEFT]];
    
    _titleTextField = [[UITextField alloc] init];
    _titleTextField.translatesAutoresizingMaskIntoConstraints = NO;
    _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_titleTextField];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_titleTextField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:titleLabel
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_titleTextField
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:PADDING_LEFT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_titleTextField
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-PADDING_RIGHT]];
    
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    descriptionLabel.textColor = [MTRColors white];
    descriptionLabel.text = @"Description:";
    [self.view addSubview:descriptionLabel];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_titleTextField
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:descriptionLabel
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:PADDING_LEFT]];
    
    _descriptionTextView = [[UITextView alloc] init];
    _descriptionTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_descriptionTextView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:descriptionLabel
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:PADDING_LEFT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-PADDING_RIGHT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionTextView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:80.0f]];
    
    UIButton *attachmentButton = [[UIButton alloc] init];
    attachmentButton.translatesAutoresizingMaskIntoConstraints = NO;
    [attachmentButton addTarget:self action:@selector(attachmentButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [attachmentButton setTitle:@"Add an Attachment" forState:UIControlStateNormal];
    [self.view addSubview:attachmentButton];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:attachmentButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_descriptionTextView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:attachmentButton
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:PADDING_LEFT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:attachmentButton
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-PADDING_RIGHT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:attachmentButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:30.0f]];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.backgroundColor = [MTRColors darkCoolGreyWithAlpha:1.0f];
    [_collectionView registerClass:[MTRAttachmentViewCell class] forCellWithReuseIdentifier:@"attachmentCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_collectionView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:attachmentButton
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_collectionView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:PADDING_LEFT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_collectionView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-PADDING_RIGHT]];
    
    UIButton *postButton = [[UIButton alloc] init];
    postButton.translatesAutoresizingMaskIntoConstraints = NO;
    [postButton setImage:[UIImage imageNamed:@"add_post"] forState:UIControlStateNormal];
    postButton.contentMode = UIViewContentModeCenter;
    [postButton addTarget:self action:@selector(postButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:postButton];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_collectionView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postButton
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:PADDING_LEFT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postButton
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-PADDING_RIGHT]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:64.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:postButton
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:-PADDING_BOTTOM]];
    
    
    _loadingView = [[MTRLoadingView alloc] init];
    _loadingView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_loadingView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loadingView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loadingView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loadingView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loadingView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    _doneBar = [[UIToolbar alloc] init];
    _doneBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_doneBar];
    _doneBarTopConstraint = [NSLayoutConstraint constraintWithItem:_doneBar
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:0.0];
    [self.view addConstraint:_doneBarTopConstraint];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_doneBar
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:_doneBar
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1.0
                                                            constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_doneBar
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:0.0
                                                           constant:44.0]];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(keyboardDonePressed)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _doneBar.items = @[flexibleSpace, doneButton];
}

-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Notifications
//////////////////////////////////////////////////////////////////////////

- (void)keyboardWillShow:(NSNotification *) notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    _keyboardSize = [keyboardFrameBegin CGRectValue].size;
    [self showDoneBar];
}

- (void)keyboardWillHide:(NSNotification *) notification {
    [self hideDoneBar];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIImagePickerControllerDelegate
//////////////////////////////////////////////////////////////////////////

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
    [_attachments addObject:image];
    [_collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UICollectionViewDatasource
//////////////////////////////////////////////////////////////////////////

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTRAttachmentViewCell *attachmentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"attachmentCell" forIndexPath:indexPath];
    UIImage *image = _attachments[indexPath.row];
    attachmentCell.imageView.image = image;
    return attachmentCell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _attachments.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UICollectionViewDelegateFlowlayout
//////////////////////////////////////////////////////////////////////////

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(70.0f, 70.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Actions
//////////////////////////////////////////////////////////////////////////

- (void)postButtonPressed {
    MTRPost *post = [[MTRPost alloc] initWithTitle:_titleTextField.text description:_descriptionTextView.text images:_attachments];
    [_loadingView startLoading];
    [[MTRApi sharedInstance] post:post withCompletion:^(MTRPost *post) {
        [_loadingView stopLoading];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)keyboardDonePressed {
    [_titleTextField resignFirstResponder];
    [_descriptionTextView resignFirstResponder];
}

- (void)attachmentButtonPressed {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add an Attachment" message:@"Choose an attachment source:" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Take a Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self takeAPhotoButtonPressed];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)takeAPhotoButtonPressed {
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    cameraUI.allowsEditing = YES;
    cameraUI.delegate = self;
    
    [self presentViewController:cameraUI animated:YES completion:nil];
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (void)showDoneBar {
    [self.view removeConstraint:_doneBarTopConstraint];
    _doneBarTopConstraint = [NSLayoutConstraint constraintWithItem:_doneBar
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:-_keyboardSize.height];
    [self.view addConstraint:_doneBarTopConstraint];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)hideDoneBar {
    [self.view removeConstraint:_doneBarTopConstraint];
    _doneBarTopConstraint = [NSLayoutConstraint constraintWithItem:_doneBar
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:0.0];
    [self.view addConstraint:_doneBarTopConstraint];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
