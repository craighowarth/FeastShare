//
//  FSMessageSenderViewController.h
//  feastshare
//
//  Created by Craig Howarth on 10/5/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

@interface FSMessageSenderViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>{
}
@property (nonatomic, strong) IBOutlet UIPickerView *picker;

- (IBAction)nextButtonPressed:(id)sender;

@end
