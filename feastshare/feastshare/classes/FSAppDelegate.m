//
//  FSAppDelegate.m
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import "FSAppDelegate.h"
#import "FSViewController.h"

@implementation FSAppDelegate 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Parse setApplicationId:@"YMwFqD1Gw49An91z6hJzFcMsRGwlE5zgt0NyRumw"
                  clientKey:@"PhQmB5llKUbD0yRqMUlwD40RAN1IhBB3FhCGOq6X"];
    
    
      
    PFACL *defaultACL = [PFACL ACL];
    
    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    FSViewController* fsViewController = [[FSViewController alloc] initWithNibName:@"FSViewController" bundle:nil];
	self.viewController = fsViewController;
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    // Present signup sheet.
    //[PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser) { // Not signed in yet?
        PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
        logInController.title = @"test";
        logInController.delegate = self;
        [fsViewController presentModalViewController:logInController animated:YES];
        
        // Allow user to choose between signup and login.
        //[self signUp];
        
        // Login (for demo: common account).
        [PFUser logInWithUsernameInBackground:@"my name" password:@"my pass"
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                
                                            } else {
                                                // The login failed. Check error to see why.
                                            }
                                        }];
    }else{
        [fsViewController.recipientChooserVC reloadData];
    }
       
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];

    return YES;
}

- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user {
    FSViewController* fsViewController = self.viewController;
    [fsViewController.recipientChooserVC reloadData];
    [self.viewController dismissModalViewControllerAnimated:YES];
    
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.viewController dismissModalViewControllerAnimated:YES];
}

- (void)signUp {
    PFUser *user = [PFUser user];
    user.username = @"my name";
    user.password = @"my pass";
    user.email = @"email@example.com";
        
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
        } else {
            // NSString *errorString = [[error userInfo] objectForKey:@"error"];
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
