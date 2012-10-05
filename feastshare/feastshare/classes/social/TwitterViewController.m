//
//  TwitterViewController.m
//  feastshare
//
//  Created by Sarah Grant on 10/4/12.
//  Copyright (c) 2012 Feast. All rights reserved.
//

#import "TwitterViewController.h"

@implementation TwitterViewController

@synthesize TwitterWebView;
//@synthesize outputTextView;

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
    // Do any additional setup after loading the view from its nib.
    [self getPublicTimeline];
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

- (void)getPublicTimeline {
    // Create a request, which in this example, grabs the public timeline.
    // This example uses version 1 of the Twitter API.
    // This may need to be changed to whichever version is currently appropriate.
    TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.twitter.com/1/statuses/public_timeline.json"] parameters:nil requestMethod:TWRequestMethodGET];
    
    // Perform the request created above and create a handler block to handle the response.
    [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSString *output;
        
        if ([urlResponse statusCode] == 200) {
            // Parse the responseData, which we asked to be in JSON format for this request, into an NSDictionary using NSJSONSerialization.
            NSError *jsonParsingError = nil;
            NSDictionary *publicTimeline = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];
            output = [NSString stringWithFormat:@"HTTP response status: %i\nPublic timeline:\n%@", [urlResponse statusCode], publicTimeline];
        }
        else {
            output = [NSString stringWithFormat:@"HTTP response status: %i\n", [urlResponse statusCode]];
        }
        
        [self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
    }];
}


- (void)displayText:(NSString *)text {
    //self.outputTextView.text = text;
    NSLog(@"TwitterViewController, displayText: %@", text);
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
    NSLog(@"!!! TwitterViewController didFailLoadWithError: %@", [error description]);
    [self showMainApp];
}

- (void) showMainApp {
    NSLog(@"showMainApp");
    [self dismissModalViewControllerAnimated:NO];
}

- (void) viewWillDisappear {
    if ([TwitterWebView isLoading]) {
        [TwitterWebView stopLoading];
    }
}

@end