    //
//  FacebookLoginViewController.m
//  Finster
//
//  Created by Todd Fearn on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookLoginViewController.h"


@implementation FacebookLoginViewController
@synthesize loginFacebookButton = _loginFacebookButton;
@synthesize facebook = _facebook;
@synthesize request = _request;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	// If the session is still valid, just request the graph
    if ([self.facebook isSessionValid]) {
		[self showWaitView:@"Loading..."];
		[self.facebook requestWithGraphPath:@"me" andDelegate:self]; 
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[_loginFacebookButton release];
	[_facebook release];
    [super dealloc];
}

- (IBAction)loginWithFacebookButtonPressed:(id)sender {
	// Do the authorization
	// TODO: Don't retain this object
	NSArray* permissions =  [[NSArray arrayWithObjects:@"email", @"publish_stream", @"offline_access", nil] retain];
	[self.facebook authorize:permissions delegate:self];
}


#pragma mark -
#pragma mark FBLoginDialogDelegate methods

- (void)fbDidLogin {
	[self showWaitView:@"Loading..."];

	// store the access token and expiration date to the Facebook user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.facebook.accessToken forKey:kFacebookAccessTokenKey];
    [defaults setObject:self.facebook.expirationDate forKey:kFacebookExpirationDateKey];
    [defaults synchronize];
	
	// Request the default graph
	[self.facebook requestWithGraphPath:@"me" andDelegate:self]; 
}

-(void)fbDidNotLogin:(BOOL)cancelled {
	// TODO: Handle this later
}

- (void)fbDidLogout {
	// TODO: Handle this later
}


#pragma mark -
#pragma mark FBLoginDialogDelegate methods

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	NSDictionary *dict = result;
	MyLog(@"%@", dict);
	MyLog(@"%@", self.facebook.accessToken);
	
	// Get the Facebook user ID
	NSString *facebookUserID = [dict objectForKey:@"id"];
	
	// Tell the server session to login using Facebook
	NSString *url = [NSString stringWithFormat:kUrlLoginUsingFacebook, facebookUserID, self.facebook.accessToken];
	
	_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
};

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	[self dismissWaitView];
};


#pragma mark -
#pragma mark ASIHTTPRequestDelegate Methods

- (void)requestFinished:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	MyLog(@"Network Error: %@", [request.error description]);
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Cannot connect to the network" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}

@end
