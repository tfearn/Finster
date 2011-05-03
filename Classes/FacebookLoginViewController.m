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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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
	NSArray* permissions =  [[NSArray arrayWithObjects:@"email", @"read_stream", nil] retain];
	[self.facebook authorize:permissions delegate:self];
}


#pragma mark -
#pragma mark FBLoginDialogDelegate methods

- (void)fbDidLogin {
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
}


#pragma mark -
#pragma mark FBLoginDialogDelegate methods

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
}

- (void)request:(FBRequest *)request didLoad:(id)result {
	NSDictionary *dict = result;
	NSLog(@"%@", dict);
	
	[self dismissModalViewControllerAnimated:YES];
};

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
};




@end
