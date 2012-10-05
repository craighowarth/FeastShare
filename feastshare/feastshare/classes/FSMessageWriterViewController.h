//
//  FSMessageWriterViewController.h
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

@interface FSMessageWriterViewController : UIViewController

@property (nonatomic, strong) UIImage *chosenImage;
@property (nonatomic, strong) NSString *chosenTweet;

@property (nonatomic, strong) IBOutlet UIImageView *chosenImageView;
@property (nonatomic, strong) IBOutlet UITextView *messageTextView;

- (IBAction)nextButtonPressed:(id)sender;

@end
