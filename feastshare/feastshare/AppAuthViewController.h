//
//  AppAuthViewController.h
//  feastshare
//
//  Created by Sarah Grant on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppAuthViewController : UIViewController {

    IBOutlet UIButton           *flickrButton;
    IBOutlet UIButton           *twitterButton;
    IBOutlet UIButton           *facebookButton;

}

- (IBAction) flickrButtonClick:(id)sender;
- (IBAction) twitterButtonClick:(id)sender;
- (IBAction) facebookButtonClick:(id)sender;
    

@end
