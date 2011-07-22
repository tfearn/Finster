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
@synthesize getUserFollowingRequest = _getUserFollowingRequest;
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

		_getUserFollowingRequest = [[GetUserFollowingRequest alloc] init];
		self.getUserFollowingRequest.delegate = self;
		[self.getUserFollowingRequest get:kUrlGetUserFollowing];
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
	[_getUserFollowingRequest release];
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
	
	[_request release];
	_request = [[Request alloc] init];
	NSString *url = [NSString stringWithFormat:kUrlUnFollowUser, self.user.userID];
	if([self.followButton.currentTitle isEqualToString:@"Follow"]) {
		url = [NSString stringWithFormat:kUrlFollowUser, self.user.userID];
	}
	
	self.request.delegate = self;
	[self.request get:[NSURL URLWithString:url]];
}

#pragma mark -
#pragma mark RequestDelegate Methods

-(void)requestComplete:(NSObject *)data {
	[self dismissWaitView];
	
	// Is this a GetUserFolowersRequest response?
	if([data isKindOfClass:[NSMutableArray class]]) {
		
		// Are we already following this user?
		NSMutableArray *users = (NSMutableArray *)data;

		for(int i=0; i<[users count]; i++) {
			User *user = [users objectAtIndex:i];
			if([self.user.userID isEqualToString:user.userID]) {
				[self.followButton setTitle:@"Unfollow" forState:UIControlStateNormal];
				break;
			}
		}
	}
	else {
		NSString *message = [NSString stringWithFormat:@"You are no longer following %@", self.user.userName];
		if([self.followButton.currentTitle isEqualToString:@"Follow"]) {
			message = [NSString stringWithFormat:@"You are now following %@", self.user.userName];
		}
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Follow User" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		
		[self.navigationController setNavigationBarHidden:NO animated:NO]; 
		[self.navigationController popToRootViewControllerAnimated:YES];;
	}
}

-(void)requestFailure:(NSString *)error {
	[self dismissWaitView];
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:error delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}


@end
