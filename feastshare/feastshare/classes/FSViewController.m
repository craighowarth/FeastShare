//
//  FSViewController.m
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import "FSViewController.h"
#import "FSRecipientChooserViewController.h"
#import "FSContentChooserViewController.h"
#import "FSMessageWriterViewController.h"
#import "FSMessageViewerViewController.h"

@interface FSViewController ()

@property (nonatomic, strong) FSRecipientChooserViewController *recipientChooserVC;
@property (nonatomic, strong) FSContentChooserViewController *contentChooserVC;
@property (nonatomic, strong) FSMessageWriterViewController *messageWriterVC;
@property (nonatomic, strong) FSMessageViewerViewController *messageViewerVC;

@end

@implementation FSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.recipientChooserVC = [[FSRecipientChooserViewController alloc] initWithNibName:nil bundle:nil];
	
	[self.contentView addSubview:[self.recipientChooserVC view]];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectRecipient:(NSString *)recipient
{
	
}



@end
