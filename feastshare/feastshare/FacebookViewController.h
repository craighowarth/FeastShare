//
//  FacebookViewController.h
//  feastshare
//
//  Created by Sarah Grant on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookViewController : UIViewController {
    IBOutlet UIWebView                  *FBwebView;
}

@property (nonatomic, retain) UIWebView *FBwebView;

- (void) showMainApp;

@end
