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
	[_userImageView release];
	[_username release];
	[_followButton release];
	[_followers release];
	[_following release];
    [super dealloc];
}



@end
