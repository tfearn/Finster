    //
//  TwitterConnectViewController.m
//  Finster
//
//  Created by Todd Fearn on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterConnectViewController.h"


@implementation TwitterConnectViewController
@synthesize delegate = _delegate;
@synthesize username = _username;
@synthesize password = _password;
@synthesize request = _request;
@synthesize jsonParser = _jsonParser;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Initialize the JSON parser
	_jsonParser = [[SBJSON alloc] init];
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
	if(self.request != nil)
		[self.request clearDelegatesAndCancel];
	
	[_username release];
	[_password release];
	[_jsonParser release];
    [super dealloc];
}

- (IBAction)loginButtonPressed:(id)sender {
	[self.username resignFirstResponder];
	[self.password resignFirstResponder];

	// Make sure the username/password are valid
	if([self.username.text length] == 0) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Invalid username" message:@"Please enter a valid username" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		return;
	}
	if([self.password.text length] == 0) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Invalid password" message:@"Please enter a valid password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		return;
	}
	
	NSString *url = [NSString stringWithFormat:kUrlTwitterConnect, self.username.text, self.password.text];
	NSString* escapedUrlString =[url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];

	[self showWaitView:@"Connecting to Twitter..."];
	
	_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:escapedUrlString]];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
}

- (IBAction)cancelButtonPressed:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark ASIHttpRequestDelegate Methods

- (void)requestFinished:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	NSString *response = [request responseString];
	
	// Parse the data
	NSError *error = nil;
	NSDictionary *dict = [self.jsonParser objectWithString:response error:&error];
	if(error != nil) {
		[Globals logError:error name:@"JSON_Parser_Error" detail:response];
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		
		_request = nil;
		return;
	}
	
	// Check the JSON return data
	
	
	
	// Set the user default Twitter Configured
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey: kTwitterConfigured];
    [userDefaults synchronize];
	
	// Call the delegate
	if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(twitterConnectComplete:)]) {
		[self.delegate twitterConnectComplete];
	}
	
	_request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Cannot connect to the network" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
	
	_request = nil;
}

@end
