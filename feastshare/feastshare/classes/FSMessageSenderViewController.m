//
//  FSMessageSenderViewController.m
//  feastshare
//
//  Created by Craig Howarth on 10/5/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import "Parse/Parse.h"
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

-(void)setupLocalReceiver:(int)digits{
    PFQuery *query = [PFQuery queryWithClassName:@"token"];
    [query whereKey:@"digits" equalTo:[NSNumber numberWithInt:digits]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if ([objects count]==1){
                // Success. Found exactly one token. Save connection remotely.
                PFObject* token = [objects objectAtIndex:0];
                PFObject* connection = [PFObject objectWithClassName:@"connection"];
                [connection setObject:[[PFUser currentUser] username] forKey:@"receiverHash"];
                [connection setObject:[token objectForKey:@"senderHash"] forKey:@"senderHash"];
                // Should add some timestamp as well.
                [connection save];
                // Delete token (Need to look up the API on how to do that).
                //..
                // Move on.
                [[NSNotificationCenter defaultCenter] postNotificationName:FSEvent_MessageSent object:nil userInfo:nil];
            }else{
                NSLog(@"Token %d not found.",digits);
                // No token found. Present error message to user.
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}


- (IBAction)nextButtonPressed:(id)sender
{
    [self setupLocalReceiver:[self.digits.text intValue]];
}

@end
