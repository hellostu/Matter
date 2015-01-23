//
//  AppDelegate.m
//  Matter
//
//  Created by Stuart Lynch on 23/01/2015.
//  Copyright (c) 2015 DBHackathon. All rights reserved.
//

#import "AppDelegate.h"
#import "MTRRootViewController.h"
#import <Dropbox/Dropbox.h>

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
    
    DBAccountManager *accountManager = [[DBAccountManager alloc] initWithAppKey:@"jb2quzu94h24k9x" secret:@"if3vy1wqrd7l9vp"];
    [DBAccountManager setSharedManager:accountManager];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(NSString *)source annotation:(id)annotation {
    DBAccount *account = [[DBAccountManager sharedManager] handleOpenURL:url];
    if (account) {
        NSLog(@"App linked successfully!");
        return YES;
    }
    return NO;
}

@end
