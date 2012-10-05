//
//  FSRecipientChooserViewController.h
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

@interface FSRecipientChooserViewController : UIViewController

@property (nonatomic, strong) IBOutlet UICollectionView *recipientCollectionView;

- (IBAction)addRecipentButtonPressed:(UIButton *)sender;
- (void)reloadData;

@end
