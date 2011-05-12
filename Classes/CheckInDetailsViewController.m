    //
//  CheckInDetailsViewController.m
//  Finster
//
//  Created by Todd Fearn on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInDetailsViewController.h"


@implementation CheckInDetailsViewController
@synthesize userImageView = _userImageView;
@synthesize username = _username;
@synthesize checkInImageView = _checkInImageView;
@synthesize description = _description;
@synthesize timestamp = _timestamp;
@synthesize symbolName = _symbolName;
@synthesize symbolType = _symbolType;
@synthesize exchangeName = _exchangeName;
@synthesize comments = _comments;
@synthesize checkIn = _checkIn;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if(self.checkIn.user.image != nil)
		self.userImageView.image = self.checkIn.user.image;
	
	self.username.text = self.checkIn.user.userName;
	
	NSString *timestamp = [Utility getDateAsTimePassed:self.checkIn.timestamp];
	self.timestamp.text = [timestamp retain];
	[timestamp release];
	
	
	
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
	[_userImageView release];
	[_username release];
	[_checkInImageView release];
	[_description release];
	[_timestamp release];
	[_symbolName release];
	[_symbolType release];
	[_exchangeName release];
	[_comments release];
	[_checkIn release];
    [super dealloc];
}


@end
