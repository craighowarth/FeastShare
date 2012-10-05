//
//  FSViewController.h
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSRecipientChooserViewController.h"

@interface FSViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, strong) FSRecipientChooserViewController *recipientChooserVC;

@end
