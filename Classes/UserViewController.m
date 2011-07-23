    //
//  UserViewController.m
//  Finster
//
//  Created by Todd Fearn on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserViewController.h"


@implementation UserViewController
@synthesize user = _user;
@synthesize request = _request;
@synthesize userImageView = _userImageView;
@synthesize username = _username;
@synthesize followButton = _followButton;
@synthesize followers = _followers;
@synthesize following = _following;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if(self.user.image != nil)
		self.userImageView.image = self.user.image;
	
	self.username.text = self.user.userName;
	self.followers.text = [NSString stringWithFormat:@"%d", self.user.followers];
	self.following.text = [NSString stringWithFormat:@"%d", self.user.following];
	
	if([self.user.groupType isEqualToString:@"you"]) {
		self.followButton.hidden = YES;
	}
	else {
		// Get your followers to determine if you are already following this user
		[self showWaitView:@"Retrieving User..."];

		_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kUrlGetUserFollowing]];
		[self.request setDelegate:self];
		[self.request setDidFinishSelector:@selector(getUserFollowingRequestFinished:)];
		[self.request setDidFailSelector:@selector(getUserFollowingRequestFailed:)];
		[self.request startAsynchronous];
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
	[_user release];
	[_request release];
	[_userImageView release];
	[_username release];
	[_followButton release];
	[_followers release];
	[_following release];
    [super dealloc];
}

- (IBAction)followButtonPressed:(id)sender {
	[self showWaitView:@"Please Wait..."];
	
	NSString *url = [NSString stringWithFormat:kUrlUnFollowUser, self.user.userID];
	if([self.followButton.currentTitle isEqualToString:@"Follow"]) {
		url = [NSString stringWithFormat:kUrlFollowUser, self.user.userID];
	}
	
	_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
}

#pragma mark -
#pragma mark RequestDelegate Methods

- (void)getUserFollowingRequestFinished:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	NSString *response = [request responseString];
	
	// Parse the data
	SBJSON *jsonParser = [[[SBJSON alloc] init] autorelease];
	NSError *error = nil;
	NSDictionary *dict = [jsonParser objectWithString:response error:&error];
	if(error != nil) {
		NSLog(@"Parser Error: %@", [error description]);
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		return;
	}

	NSArray *following = [dict objectForKey:@"following"];
	
	// Are we already following this user?
	for(int i=0; i<[following count]; i++) {
		NSDictionary *userParentDict = [following objectAtIndex:i];
		NSDictionary *userDict = [userParentDict objectForKey:@"user"];
		
		NSString *userID = [[userDict objectForKey:@"id"] stringValue];
		if([self.user.userID isEqualToString:userID]) {
			[self.followButton setTitle:@"Unfollow" forState:UIControlStateNormal];
			break;
		}
	}
}

- (void)getUserFollowingRequestFailed:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:[[request error] description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}

-(void)requestComplete:(NSObject *)data {
	[self dismissWaitView];
	
	NSString *message = [NSString stringWithFormat:@"You are no longer following %@", self.user.userName];
	if([self.followButton.currentTitle isEqualToString:@"Follow"]) {
		message = [NSString stringWithFormat:@"You are now following %@", self.user.userName];
	}
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Follow User" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
	
	[self.navigationController setNavigationBarHidden:NO animated:NO]; 
	[self.navigationController popToRootViewControllerAnimated:YES];;
}

-(void)requestFailure:(NSString *)error {
	[self dismissWaitView];
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:error delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}


@end
