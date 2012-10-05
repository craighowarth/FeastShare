//
//  FSMessageWriterViewController.m
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//
#import "Parse/Parse.h"
#import "FSMessageWriterViewController.h"
#import "FSConstants.h"
#import "SVProgressHUD.h"

@interface FSMessageWriterViewController ()

@end

@implementation FSMessageWriterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)postImage:(UIImage *)image withMessage:(NSString *)message toReceiver:(NSString *)receiverHash
{
    NSData *imageData = UIImagePNGRepresentation(image);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    [imageFile save];
    
    PFObject *post = [PFObject objectWithClassName:@"Post"];
    [post setObject:receiverHash forKey:@"receiverHash"];
    [post setObject:[[PFUser currentUser] username] forKey:@"senderHash"];
    [post setObject:message forKey:@"message"];
    [post setObject:imageFile forKey:@"image"];
    [post save];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//[self.chosenImageView setImage:self.chosenImage];
	[self.messageTextView setText:self.chosenTweet];
}

- (NSString *)message
{
	return [self.messageTextView text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextButtonPressed:(id)sender
{
	[SVProgressHUD showWithStatus:@"Posting message"];

	[self performSelector:@selector(postMessage) withObject:nil afterDelay:0.5f];
}

- (void)postMessage
{
    [self postImage:self.chosenImage withMessage:[self message] toReceiver:[[PFUser currentUser] username]];
	
	[SVProgressHUD dismiss];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:FSEvent_MessageWritten object:nil userInfo:nil];
}

@end
