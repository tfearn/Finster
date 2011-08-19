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
@synthesize followUnfollowUserRequest = _followUnfollowUserRequest;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = self.user.userName;
	
	if([self.user.groupType isEqualToString:@"you"]) {
		self.followButton.hidden = YES;
	}
	else {
		// Are we following this user?
		NSString *url = [NSString stringWithFormat:kUrlIsFollowingUser, self.user.userID];

		_isFollowingUserRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
		[_isFollowingUserRequest setDelegate:self];
		[_isFollowingUserRequest setDidFinishSelector:@selector(isFollowingUserRequestComplete:)];
		[_isFollowingUserRequest setDidFailSelector:@selector(isFollowingUserRequestFailure:)];
		[_isFollowingUserRequest startAsynchronous];
		
		[self showWaitView:@"Retrieving user..."];
	}
	
	// Retrieve the user stats
	[self getData];
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
	if(self.isFollowingUserRequest != nil)
		[self.isFollowingUserRequest clearDelegatesAndCancel];
	if(self.followUnfollowUserRequest != nil)
		[self.followUnfollowUserRequest clearDelegatesAndCancel];
	
	[_followButton release];
    [super dealloc];
}

- (IBAction)followButtonPressed:(id)sender {
	NSString *url = [NSString stringWithFormat:kUrlUnFollowUser, self.user.userID];
	if([self.followButton.currentTitle isEqualToString:@"Follow"]) {
		url = [NSString stringWithFormat:kUrlFollowUser, self.user.userID];
	}
	
	_followUnfollowUserRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	[_followUnfollowUserRequest setDelegate:self];
	[_followUnfollowUserRequest setDidFinishSelector:@selector(followUnFollowUserRequestComplete:)];
	[_followUnfollowUserRequest setDidFailSelector:@selector(followUnFollowUserRequestFailure:)];
	[_followUnfollowUserRequest startAsynchronous];

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
		[Globals logError:error name:@"JSON_Parser_Error" detail:response];
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		return;
	}
	
	int isFollowingUser = [[dict objectForKey:@"isfollowinguser"] intValue];
	if(isFollowingUser == 1)
		[self.followButton setTitle:@"Unfollow" forState:UIControlStateNormal];
	else
		[self.followButton setTitle:@"Follow" forState:UIControlStateNormal];
	
	_isFollowingUserRequest = nil;
}

- (void)isFollowingUserRequestFailure:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	[Globals showNetworkError:request.error];
	
	_isFollowingUserRequest = nil;
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
	
	_followUnfollowUserRequest = nil;
}

- (void)followUnFollowUserRequestFailure:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	[Globals showNetworkError:request.error];

	_followUnfollowUserRequest = nil;
}


@end
