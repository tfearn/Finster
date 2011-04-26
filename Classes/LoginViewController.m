    //
//  LoginViewController.m
//  Finster
//
//  Created by Todd Fearn on 6/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (Private)
- (void)hideKeyboard;
- (void)doLoginRequest:(NSString *)username password:(NSString *)password;
@end


@implementation LoginViewController
@synthesize username = _username;
@synthesize password = _password;
@synthesize request = _request;

- (void)viewDidLoad {
    [super viewDidLoad];

	// Saved username / password?
    NSString *usernameKey = [[NSUserDefaults standardUserDefaults] stringForKey: kUsernameKey];
    NSString *passwordKey = [[NSUserDefaults standardUserDefaults] stringForKey: kPasswordKey];
	if(usernameKey != nil)
		[self.username setText:usernameKey];
	if(passwordKey != nil)
		[self.password setText:passwordKey];
	
	if(usernameKey != nil && passwordKey != nil)
		[self doLoginRequest:usernameKey password:passwordKey];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)hideKeyboard {
	[self.username resignFirstResponder];
	[self.password resignFirstResponder];
}

- (void)doLoginRequest:(NSString *)username password:(NSString *)password {
	[self showWaitView:@"Authenticating..."];
	
	// Save the username/password
	[Globals setUsername:username];
	[Globals setPassword:password];
	
	// Login request
	[_request release];
	_request = [[Request alloc] init];
	self.request.delegate = self;
	[self.request get:[NSURL URLWithString:kUrlLogin]];
}

- (void)dealloc {
	[_username release];
	[_password release];
	[_request release];
	
    [super dealloc];
}

- (IBAction)signInPressed:(id)selector {
	[self hideKeyboard];
	
	// Save the username and password?
	NSString *usernameKey = nil;
	NSString *passwordKey = nil;
	if([self.username.text length])
		usernameKey = self.username.text;
	if([self.password.text length])
		passwordKey = self.password.text;
		
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	if (standardUserDefaults) {
		[standardUserDefaults setObject:usernameKey forKey:kUsernameKey];
		[standardUserDefaults setObject:passwordKey forKey:kPasswordKey];
		[standardUserDefaults synchronize];
	}
	
	[self doLoginRequest:self.username.text password:self.password.text];
}

- (IBAction)forgotPressed:(id)selector {
}

#pragma mark -
#pragma mark RequestDelegate Methods

-(void)requestComplete:(NSObject *)data {
	// Dismiss the view
	[self dismissWaitView];
	[self dismissModalViewControllerAnimated:YES];
}

-(void)requestFailure:(NSError *)error {
	[self dismissWaitView];
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Login failed" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}

@end
