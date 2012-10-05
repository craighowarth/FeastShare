//
//  FacebookViewController.m
//  feastshare
//
//  Created by Sarah Grant on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import "FacebookViewController.h"

@implementation FacebookViewController

@synthesize FBwebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[super viewDidLoad];
    NSString *urlAddress = @"http://ff.nws.hu/api/1/oauth/authorize/facebook";
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [FBwebView loadRequest:requestObj];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}



#pragma mark UIWebView delegate methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	// starting the load, show the activity indicator in the status bar
	//[UIApplication sharedApplication].isNetworkActivityIndicatorVisible = YES;
    //NSLog(@"!!! FacebookViewController webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	// finished loading, hide the activity indicator in the status bar
	//[UIApplication sharedApplication].isNetworkActivityIndicatorVisible = YES;
    
    NSURL *currentUrl = webView.request.mainDocumentURL;
    NSString *urlString = [currentUrl absoluteString];
    
    NSLog(@"urlString: %@", urlString);
    
    //if( [urlString rangeOfString:@"http://ff.nws.hu/api/1/oauth/result/success/new"].location != NSNotFound )
    //{
    //}
    //else if( [urlString rangeOfString:@"http://ff.nws.hu/api/1/oauth/result/success/successful+auth"].location != NSNotFound ) {
        
        // they are a returning user; let them into app
        [self showMainApp];
    //}
    //else if( [urlString rangeOfString:@"http://ff.nws.hu/api/1/oauth/result/fail"].location != NSNotFound ) {
        //NSLog(@"auth FAILED");
        //[self dismissModalViewControllerAnimated:YES];
        //NSString *displayMessage = @"Facebook authorization failed.";
        //[[[UIAlertView alloc] initWithTitle:@"Authorization Error" message:displayMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    //}
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	// load error, hide the activity indicator in the status bar
	//[UIApplication sharedApplication].isNetworkActivityIndicatorVisible = NO;
    // Don't really need error handling, here. Just plow along. :-) FOR NOW! This may be brittle and should be looked at before full launch.
    NSLog(@"!!! FacebookViewController didFailLoadWithError: %@", [error description]);
    [self showMainApp];
}

- (void) showMainApp {
    NSLog(@"showMainApp");
    [self dismissModalViewControllerAnimated:NO];
}

- (void) viewWillDisappear {
    if ([FBwebView isLoading]) {
        [FBwebView stopLoading];
    }
}

@end
