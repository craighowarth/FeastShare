//
//  FSAppDelegate.h
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@class FSViewController;

@interface FSAppDelegate : UIResponder <UIApplicationDelegate,PFLogInViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FSViewController *viewController;

@end
