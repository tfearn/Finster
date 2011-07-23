//
//  CheckInResult.m
//  Finster
//
//  Created by Todd Fearn on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInResult.h"


@implementation CheckInResult
@synthesize badgeID = _badgeID;
@synthesize checkInsForTicker = _checkInsForTicker;
@synthesize otherCheckInsForTicker = _otherCheckInsForTicker;
@synthesize otherTickerInterest = _otherTickerInterest;
@synthesize pointsEarned = _pointsEarned;
@synthesize totalPoints = _totalPoints;

- (void)dealloc {
	[super dealloc];
}

@end
