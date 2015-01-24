//
//  AppDelegate.m
//  Matter
//
//  Created by Stuart Lynch on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "AppDelegate.h"
#import "MTRRootViewController.h"
#import "MTRLoginViewController.h"
#import "MTRTransitionContainer.h"
#import "MTRColors.h"

#import <Dropbox/Dropbox.h>

@interface AppDelegate () {
    UINavigationController *_navigationController;
    MTRTransitionContainer *_transitionContainer;
}

@end

@implementation AppDelegate

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
//////////////////////////////////////////////////////////////////////////

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    if([[DBAccountManager sharedManager] linkedAccount] != nil) {
        MTRLoginViewController *loginViewController = [[MTRLoginViewController alloc] init];
        _transitionContainer = [[MTRTransitionContainer alloc] initWithViewController:loginViewController];
    } else {
        MTRRootViewController *rootViewController = [[MTRRootViewController alloc] init];
        _transitionContainer = [[MTRTransitionContainer alloc] initWithViewController:rootViewController];
    }
    
    
    _navigationController = [[UINavigationController alloc] initWithRootViewController:_transitionContainer];
    self.window.rootViewController = _navigationController;
    
    DBAccountManager *accountManager = [[DBAccountManager alloc] initWithAppKey:@"jb2quzu94h24k9x" secret:@"if3vy1wqrd7l9vp"];
    [DBAccountManager setSharedManager:accountManager];
    
    [self updateAppearance];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(NSString *)source annotation:(id)annotation {
    DBAccount *account = [[DBAccountManager sharedManager] handleOpenURL:url];
    if (account) {
        NSLog(@"App linked successfully!");
        MTRRootViewController *rootViewController = [[MTRRootViewController alloc] init];
         [_transitionContainer transitionToViewController:rootViewController withAnimation:UIViewAnimationOptionTransitionCrossDissolve];
        return YES;
    }
    return NO;
}

//////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Methods
//////////////////////////////////////////////////////////////////////////

- (void)updateAppearance {
    [UINavigationBar appearance].barTintColor = [MTRColors blue];
    [UINavigationBar appearance].tintColor = [MTRColors white];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName : [MTRColors white]};
    [UINavigationBar appearance].barStyle = UIBarStyleBlackTranslucent;
}

@end
