    //
//  CheckInsByUserViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInsByUserViewController.h"


@implementation CheckInsByUserViewController
@synthesize userID = _userID;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *title = [NSString stringWithFormat:@"CheckIns for %@", self.userID];
	
	[self.navigationItem setTitle:title];
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
	[_userID release];
    [super dealloc];
}

- (NSString *)getRequestUrl {
	NSString *url = [NSString stringWithFormat:kUrlGetCheckInsByUser, self.userID];
	
	return url;
}

@end
