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
@synthesize timestamp = _timestamp;
@synthesize comments = _comments;
@synthesize checkIn = _checkIn;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	if(self.checkIn.user.image != nil)
		self.userImageView.image = self.checkIn.user.image;
	
	self.username.text = self.checkIn.user.userName;
	
	TimePassedFormatter *timePassedFormatter = [[[TimePassedFormatter alloc] init] autorelease];
	self.timestamp.text = [timePassedFormatter format:self.checkIn.timestamp];

	/*
	switch (self.checkIn.checkinType) {
		case kCheckInTypeIBought:
			self.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dollars-icon" ofType:@"png"]];
			break;
		case kCheckInTypeISold:
			self.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"check-icon" ofType:@"png"]];
			break;
		case kCheckinTypeGoodRumour:
			self.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"thumbs-up-icon" ofType:@"png"]];
			break;
		case kCheckinTypeBadRumour:
			self.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"thumbs-down-icon" ofType:@"png"]];
			break;
		case kCheckInTypeImBullish:
			self.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bullish-icon" ofType:@"png"]];
			break;
		case kCheckInTypeImBearish:
			self.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bearish-icon" ofType:@"png"]];
			break;
		default:
			break;
	}
	 */
	
	CheckInTypeFormatter *formatter = [[[CheckInTypeFormatter alloc] init] autorelease];
	self.description.text = [formatter format:self.checkIn.checkinType symbol:self.checkIn.ticker.symbol];
	
	self.symbolName.text = self.checkIn.ticker.symbolName;
	
	self.symbolType.text = self.checkIn.ticker.typeName;
	
	self.exchangeName.text = self.checkIn.ticker.exchangeName;
	
	if([self.checkIn.comment length]) {
		NSString *comment = [NSString stringWithFormat:@"\"%@\"", self.checkIn.comment];
		self.comments.text = comment;
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
	[_userImageView release];
	[_username release];
	[_checkInImageView release];
	[_timestamp release];
	[_comments release];
	[_checkIn release];
    [super dealloc];
}

- (IBAction)usernamePressed:(id)sender {
	if([self.checkIn.user.groupType caseInsensitiveCompare:@"you"] != NSOrderedSame) {
		UserViewController *controller = [[UserViewController alloc] init];
		controller.user = self.checkIn.user;
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];	
	}
}



@end
