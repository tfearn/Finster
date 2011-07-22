//
//  CheckInRequest.m
//  Finster
//
//  Created by Todd Fearn on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInRequest.h"


@implementation CheckInRequest
@synthesize badgeID = _badgeID;
@synthesize checkInsForTicker = _checkInsForTicker;
@synthesize otherCheckInsForTicker = _otherCheckInsForTicker;
@synthesize otherTickerInterest = _otherTickerInterest;
@synthesize pointsEarned = _pointsEarned;
@synthesize totalPoints = _totalPoints;

- (void)get:(NSString *)url {
	NSURL *nsurl = [NSURL URLWithString:url];
	[self setParseResponse:YES];	// Let's parse the JSON response
	[super get:nsurl];
}

- (NSObject *)getParsedDataObject {
	return self;
}

- (void)dealloc {
	[super dealloc];
}

- (void)foundObject:(NSDictionary *)dict {
	MyLog(@"%@", dict);
	
	self.badgeID = [[dict objectForKey:@"badgeID"] intValue];
	self.checkInsForTicker = [[dict objectForKey:@"checkInsForTicker"] intValue];
	self.otherCheckInsForTicker = [[dict objectForKey:@"otherCheckInsForTicker"] intValue];
	self.otherTickerInterest = [[dict objectForKey:@"otherTickerInterest"] intValue];
	self.pointsEarned = [[dict objectForKey:@"pointsEarned"] intValue];
	self.totalPoints = [[dict objectForKey:@"totalPoints"] intValue];
}

@end
