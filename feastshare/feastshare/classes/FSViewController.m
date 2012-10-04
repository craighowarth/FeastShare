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
#import "FSConstants.h"

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

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recipientChosen:) name:FSEvent_RecipientChosen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentChosen:) name:FSEvent_ContentChosen object:nil];

	self.recipientChooserVC = [[FSRecipientChooserViewController alloc] initWithNibName:nil bundle:nil];
	
	[self.contentView addSubview:[self.recipientChooserVC view]];
	[self addChildViewController:self.recipientChooserVC];
	[self.recipientChooserVC didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)recipientChosen:(NSNotification *)n
{
	NSLog(@"%s", __FUNCTION__);
	
	if (self.contentChooserVC) {
		self.contentChooserVC = [[FSContentChooserViewController alloc] initWithNibName:nil bundle:nil];
	}
	
//	[self addChildViewController:self.contentChooserVC];
//	[self transitionFromViewController:self.recipientChooserVC
//					  toViewController:self.contentChooserVC
//							  duration:0.5f
//							   options:UIViewAnimationOptionTransitionCrossDissolve
//							animations:^{
//								//[self.recipientChooserVC.view removeFromSuperview];
//								//[self.contentView addSubview:[self.contentChooserVC view]];
//							}
//							completion:^(BOOL finished) {
//								//[self.contentChooserVC didMoveToParentViewController:self];
//								//[self.recipientChooserVC removeFromParentViewController];
//							}];
	
}

- (void)contentChosen:(NSNotification *)n
{
	NSLog(@"%s", __FUNCTION__);
	
}



@end
