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
	self.chosenImage = [UIImage imageNamed:@"minis_dog.jpg"];
	self.chosenTweet = @"Second day at hackathon at #thefeast lets keep on designing http://instagram.com/p/QZ85N-pg6w/";
	
	[[NSNotificationCenter defaultCenter] postNotificationName:FSEvent_ContentChosen object:nil userInfo:nil];
	
}

@end
