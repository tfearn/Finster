    //
//  FollowersViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FollowersViewController.h"


@implementation FollowersViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"Followers";
	
	[self getUrl:kUrlGetUserFollowers];
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
    [super dealloc];
}

- (NSString *)getReturnedDataJSONRoot {
	return @"follower";
}

@end
