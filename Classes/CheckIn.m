//
//  CheckIn.m
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckIn.h"


@implementation CheckIn
@synthesize checkinID = _checkinID;
@synthesize timestamp = _timestamp;
@synthesize checkinType = _checkinType;
@synthesize user = _user;
@synthesize ticker = _ticker;
@synthesize comment = _comment;

- (void)dealloc {
	[_checkinID release];
	[_timestamp release];
	[_user release];
	[_ticker release];
	[_comment release];
	[super dealloc];
}

@end
