//
//  FlickrViewController.h
//  feastshare
//
//  Created by Sarah Grant on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrViewController : UIViewController {
    IBOutlet UIWebView                  *FlickrWebView;
    
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image 
}

@property (nonatomic, retain) UIWebView *FlickrWebView;

- (void) showMainApp;

@end
