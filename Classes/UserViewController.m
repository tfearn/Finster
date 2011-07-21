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
@synthesize getUserFollowersRequest = _getUserFollowersRequest;
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

		_getUserFollowersRequest = [[GetUserFollowersRequest alloc] init];
		self.getUserFollowersRequest.delegate = self;
		NSString *url = [NSString stringWithFormat:kUrlGetUserFollowers, 100];
		[self.getUserFollowersRequest get:url];
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
	[_getUserFollowersRequest release];
	[_request release];
	[_userImageView release];
	[_username release];
	[_followButton release];
	[_followers release];
	[_following release];
    [super dealloc];
}

- (IBAction)followButtonPressed:(id)sender {
	[self showWaitView:@"Following..."];
	
	[_request release];
	_request = [[Request alloc] init];
	NSString *url = [NSString stringWithFormat:kUrlFollowUser, self.user.userID];
	
	self.request.delegate = self;
	[self.request get:[NSURL URLWithString:url]];
}

#pragma mark -
#pragma mark RequestDelegate Methods

-(void)requestComplete:(NSObject *)data {
	[self dismissWaitView];
	
	// Is this a GetUserFolowersRequest response?
	if([data isKindOfClass:[GetUserFollowersRequest class]]) {
		
	}
	else {
	}
	
	NSString *message = [NSString stringWithFormat:@"You are now following %@", self.user.userName];
	
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
