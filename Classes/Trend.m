//
//  Trend.m
//  Finster
//
//  Created by Todd Fearn on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Trend.h"


@implementation Trend
@synthesize ticker = _ticker;
@synthesize checkins = _checkins;
@synthesize positive = _positive;
@synthesize negative = _negative;

- (void)dealloc {
	[_ticker release];
	[super dealloc];
}
@end
