//
//  FSMessageViewerViewController.h
//  feastshare
//
//  Created by Craig Howarth on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSMessageViewerViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    IBOutlet UITableView* tableview;
}

@end
