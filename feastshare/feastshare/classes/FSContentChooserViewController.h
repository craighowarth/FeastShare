//
//  FSContentChooserViewController.h
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

@interface FSContentChooserViewController : UIViewController

@property (nonatomic, strong) UIImage *chosenImage;
@property (nonatomic, strong) NSString *chosenTweet;

- (IBAction)nextButtonPressed:(id)sender;

@end
