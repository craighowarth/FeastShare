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

@interface FSRecipientChooserViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *connections;

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

-(void)reloadData{
    [self getAllConnections];
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
            }else{
                // No token found. Present error message to user.
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];  
}

- (IBAction)recipientButtonPressed:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:FSEvent_EnterToken object:nil userInfo:nil];
}


- (IBAction)addRecipentButtonPressed:(UIButton *)sender{
    [self setupRemoteReceiver];
}


-(void)setupRemoteReceiver{
    int random4digits = 0;
    while (random4digits<1000){ // create a number from 1000 to 9999
        random4digits = rand() % 10000;
    }
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Setup Recipient" message:[NSString stringWithFormat:@"Please enter the recipient token %04d on the recipient's iPad.",random4digits] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

-(void)getAllConnections
{
    PFQuery *query = [PFQuery queryWithClassName:@"connection"];
    [query whereKey:@"senderHash" equalTo:[[PFUser currentUser] username]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // All previsouly configured receivers are in the objects array. Display to user.
			NSLog(@"Successfully retrieved %d connections.", objects.count);
            self.connections = objects;
            [self.recipientCollectionView reloadData];
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
	
	//[self getAllConnections];
	
	UINib *cellNib = [UINib nibWithNibName:@"FSRecipientCell" bundle:nil];
	[self.recipientCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"recipientCell"];
		
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	[flowLayout setItemSize:CGSizeMake(366, 396)];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	[self.recipientCollectionView setCollectionViewLayout:flowLayout];
	
	[self.recipientCollectionView setDelegate:self];
	[self.recipientCollectionView setDataSource:self];
	
	[self.recipientCollectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [self.connections count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"recipientCell" forIndexPath:indexPath];
//	cell.backgroundColor = [UIColor whiteColor];
	
//	cell.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fry.png"]];
//	[cell setFrame:CGRectMake(0, 0, 300, 300)];
	
	NSInteger row = [indexPath row]+1;
	UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
	NSString *imageName = [NSString stringWithFormat:@"polaroids_image_0%d.png", row];
	[imageView setImage:[UIImage imageNamed:imageName]];
	
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	PFObject *receiver = [self.connections objectAtIndex:indexPath.row];
    NSDictionary *recieverHash = [NSDictionary dictionaryWithObject:[receiver objectForKey:@"receiverHash"] forKey:@"receievrHash"];

	[[NSNotificationCenter defaultCenter] postNotificationName:FSEvent_RecipientChosen object:nil userInfo:recieverHash];
}

//- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout *)cvl sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//	return CGSizeMake(300, 300);
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//	return UIEdgeInsetsMake(50, 20, 50, 20);
//}

@end
