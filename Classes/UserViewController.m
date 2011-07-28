    //
//  UserViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserViewController.h"


@implementation UserViewController
@synthesize followButton = _followButton;
@synthesize isFollowingUserRequest = _isFollowingUserRequest;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = self.user.userName;
	
	// Are we following this user?
	NSString *url = [NSString stringWithFormat:kUrlIsFollowingUser, self.user.userID];
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(isFollowingUserRequestComplete:)];
	[request setDidFailSelector:@selector(isFollowingUserRequestFailure:)];
	[self.queue addOperation:request];
	
	[self showWaitView:@"Retrieving user..."];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
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
	[_followButton release];
    [super dealloc];
}

- (IBAction)followButtonPressed:(id)sender {
	NSString *url = [NSString stringWithFormat:kUrlUnFollowUser, self.user.userID];
	if([self.followButton.currentTitle isEqualToString:@"Follow"]) {
		url = [NSString stringWithFormat:kUrlFollowUser, self.user.userID];
	}
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(followUnFollowUserRequestComplete:)];
	[request setDidFailSelector:@selector(followUnFollowUserRequestFailure:)];
	[self.queue addOperation:request];

	[self showWaitView:@"Please Wait..."];
}

#pragma mark -
#pragma mark RequestDelegate Methods

- (void)isFollowingUserRequestComplete:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	NSString *response = [request responseString];
	
	SBJSON *jsonParser = [[[SBJSON alloc] init] autorelease];
	
	// Parse the data
	NSError *error = nil;
	NSDictionary *dict = [jsonParser objectWithString:response error:&error];
	MyLog(@"%@", dict);
	if(error != nil) {
		NSLog(@"Parser Error: %@", [error description]);
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		return;
	}
	
	int isFollowingUser = [[dict objectForKey:@"isFollowingUser"] intValue];
	if(! isFollowingUser)
		[self.followButton setTitle:@"Unfollow" forState:UIControlStateNormal];
	else
		[self.followButton setTitle:@"Follow" forState:UIControlStateNormal];
}

- (void)isFollowingUserRequestFailure:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:[request.error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}

- (void)followUnFollowUserRequestComplete:(ASIHTTPRequest *)request {
	NSString *message = [NSString stringWithFormat:@"You are no longer following %@", self.user.userName];
	if([self.followButton.currentTitle isEqualToString:@"Follow"]) {
		message = [NSString stringWithFormat:@"You are now following %@", self.user.userName];
	}
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Follow User" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
	
	[self.navigationController setNavigationBarHidden:NO animated:NO]; 
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)followUnFollowUserRequestFailure:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:[request.error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}


@end
