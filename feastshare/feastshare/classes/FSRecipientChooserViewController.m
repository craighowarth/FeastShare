//
//  FSRecipientChooserViewController.m
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//
#import "Parse/Parse.h"
#import "FSRecipientChooserViewController.h"
#import "FSConstants.h"

@interface FSRecipientChooserViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation FSRecipientChooserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initReceiverSetup{
    int random4digits = rand() % 10000;
    PFObject *token = [PFObject objectWithClassName:@"token"];
    [token setObject:[NSNumber numberWithInt:random4digits] forKey:@"digits"];
    [token setObject:[PFUser currentUser] forKey:@"senderHash"];
    [token save];
}

-(void)getAllReceivers{
    PFQuery *query = [PFQuery queryWithClassName:@"connections"];
    [query whereKey:@"senderHash" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d receivers.", objects.count);
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[self.recipientTableView setDelegate:self];
	[self.recipientTableView setDataSource:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
	}
    
	[[cell textLabel] setText:[NSString stringWithFormat:@"%d",[indexPath row]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"%s", __FUNCTION__);

	[[NSNotificationCenter defaultCenter] postNotificationName:FSEvent_RecipientChosen object:nil userInfo:nil];
}


@end
