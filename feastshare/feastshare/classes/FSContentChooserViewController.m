//
//  FSContentChooserViewController.m
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import "FSContentChooserViewController.h"
#import "FSConstants.h"

@interface FSContentChooserViewController ()

@end

@implementation FSContentChooserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextButtonPressed:(id)sender
{
	self.chosenImage = [UIImage imageNamed:@"molly_me.jpeg"];
	self.chosenTweet = @"I just had dinner at Per Se!";
	
	[[NSNotificationCenter defaultCenter] postNotificationName:FSEvent_ContentChosen object:nil userInfo:nil];
	
}

@end
