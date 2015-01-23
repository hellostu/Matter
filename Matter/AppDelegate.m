//
//  AppDelegate.m
//  Matter
//
//  Created by Stuart Lynch on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "AppDelegate.h"
#import "MTRRootViewController.h"

@interface AppDelegate ()

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
    
    MTRRootViewController *mainViewController = [[MTRRootViewController alloc] init];
    self.window.rootViewController = mainViewController;
    
    return YES;
}

@end
