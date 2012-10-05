//
//  FSMessageSenderViewController.m
//  feastshare
//
//  Created by Craig Howarth on 10/5/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import "FSMessageSenderViewController.h"
#import "FSConstants.h"

@interface FSMessageSenderViewController ()

@end

@implementation FSMessageSenderViewController

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
	[[NSNotificationCenter defaultCenter] postNotificationName:FSEvent_MessageSent object:nil userInfo:nil];
}

@end
