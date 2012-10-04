//
//  FSMessageWriterViewController.m
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//
#import "Parse/Parse.h"
#import "FSMessageWriterViewController.h"

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

-(void)postImage:(UIImage*)image withMessage:(NSString*)message toReceiver:(NSString*)receiverHash{
    PFObject *gameScore = [PFObject objectWithClassName:@"Post"];
    [gameScore setObject:receiverHash forKey:@"receiverHash"];
    [gameScore setObject:[PFUser currentUser] forKey:@"senderHash"];
    [gameScore setObject:message forKey:@"message"];
    [gameScore setObject:image forKey:@"image"];
    [gameScore save];

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

@end
