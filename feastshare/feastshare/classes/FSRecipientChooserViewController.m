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

@interface FSRecipientChooserViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSArray* connections;
}

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


-(IBAction)addRecipientButtonPressed:(id)sender{
    [self setupRemoteReceiver];
}

-(void)setupRemoteReceiver{
    int random4digits = rand() % 10000;
    PFQuery *query = [PFQuery queryWithClassName:@"token"];
    [query whereKey:@"digits" equalTo:[NSNumber numberWithInt:random4digits]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if ([objects count]>0){
                // Duplicate. Try again with a differend random number.
                [self setupRemoteReceiver];
            }else{
                // No duplicate in database. Save token and display to user.
                PFObject *token = [PFObject objectWithClassName:@"token"];
                [token setObject:[NSNumber numberWithInt:random4digits] forKey:@"digits"];
                [token setObject:[[PFUser currentUser] username] forKey:@"senderHash"];
                // Should add some timestamp as well.
                [token save];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Setup Recipient" message:[NSString stringWithFormat:@"Please enter the recipient token %d on the recipient's iPad.",random4digits] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)getAllConnections{
    PFQuery *query = [PFQuery queryWithClassName:@"connections"];
    [query whereKey:@"senderHash" equalTo:[[PFUser currentUser] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // All previsouly configured receivers are in the objects array. Display to user.
            NSLog(@"Successfully retrieved %d connections.", objects.count);
            connections = objects;
            [self.recipientTableView reloadData];
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
    [self getAllConnections];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [connections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
	}
    
    PFObject* receiver = [connections objectAtIndex:indexPath.row];
    cell.textLabel.text = [receiver objectForKey:@"receiverHash"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"%s", __FUNCTION__);

	[[NSNotificationCenter defaultCenter] postNotificationName:FSEvent_RecipientChosen object:nil userInfo:nil];
}


@end
