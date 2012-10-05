//
//  TwitterViewController.h
//  feastshare
//
//  Created by Sarah Grant on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>

@interface TwitterViewController : UIViewController {
    IBOutlet UIWebView                  *TwitterWebView;
}

@property (nonatomic, retain) UIWebView *TwitterWebView;
//@property (strong, nonatomic) IBOutlet UITextView *outputTextView;

- (void) showMainApp;
//- (void)displayText:(NSString *)text;
- (void)getPublicTimeline;

@end
