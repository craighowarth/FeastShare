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
#import "FSMessageSenderViewController.h"
#import "FSConstants.h"

@interface FSViewController ()

@property (nonatomic, strong) FSRecipientChooserViewController *recipientChooserVC;
@property (nonatomic, strong) FSContentChooserViewController *contentChooserVC;
@property (nonatomic, strong) FSMessageWriterViewController *messageWriterVC;
@property (nonatomic, strong) FSMessageViewerViewController *messageViewerVC;
@property (nonatomic, strong) FSMessageSenderViewController *messageSenderVC;

@end

@implementation FSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recipientChosen:) name:FSEvent_RecipientChosen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentChosen:) name:FSEvent_ContentChosen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageWritten:) name:FSEvent_MessageWritten object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageSent:) name:FSEvent_MessageSent object:nil];
	
	self.recipientChooserVC = [[FSRecipientChooserViewController alloc] initWithNibName:nil bundle:nil];
	self.contentChooserVC = [[FSContentChooserViewController alloc] initWithNibName:nil bundle:nil];
	self.messageWriterVC = [[FSMessageWriterViewController alloc] initWithNibName:nil bundle:nil];
	self.messageSenderVC = [[FSMessageSenderViewController alloc] initWithNibName:nil bundle:nil];
	self.messageViewerVC = [[FSMessageViewerViewController alloc] initWithNibName:nil bundle:nil];

	[self addChildViewController:self.recipientChooserVC];
	[self.contentView addSubview:[self.recipientChooserVC view]];
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
	
	[self transitionFromViewController:self.recipientChooserVC
					  toViewController:self.contentChooserVC];
}

- (void)contentChosen:(NSNotification *)n
{
	NSLog(@"%s", __FUNCTION__);

	[self.messageWriterVC setChosenImage:[self.contentChooserVC chosenImage]];
	[self.messageWriterVC setChosenTweet:[self.contentChooserVC chosenTweet]];
	
	[self transitionFromViewController:self.contentChooserVC
					  toViewController:self.messageWriterVC];
}

- (void)messageWritten:(NSNotification *)n
{
	NSLog(@"%s", __FUNCTION__);

	[self transitionFromViewController:self.messageWriterVC
					  toViewController:self.messageSenderVC];
}

- (void)messageSent:(NSNotification *)n
{
	NSLog(@"%s", __FUNCTION__);
	
	[self transitionFromViewController:self.messageSenderVC
					  toViewController:self.messageViewerVC];
}



- (void)transitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
	if (fromVC == toVC)
	{
		// cannot transition to same
		return;
	}
	
	// notify
	[fromVC willMoveToParentViewController:nil];
	[self addChildViewController:toVC];
	
	// transition
	[self transitionFromViewController:fromVC
					  toViewController:toVC
							  duration:0.5f
							   options:UIViewAnimationOptionTransitionCrossDissolve
							animations:^{
							}
							completion:^(BOOL finished) {
								[toVC didMoveToParentViewController:self];
								[fromVC removeFromParentViewController];
							}];
}


@end
