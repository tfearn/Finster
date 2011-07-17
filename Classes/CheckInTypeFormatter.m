//
//  CheckInTypeFormatter.m
//  Finster
//
//  Created by Todd Fearn on 5/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInTypeFormatter.h"


@implementation CheckInTypeFormatter
@synthesize formattedValue = _formattedValue;

- (id)init {
    if (self = [super init]) {
		_formattedValue = [[NSString alloc] init];
    }
    return self;
}

- (NSString *)format:(int)checkInType symbol:(NSString *)symbol {
	
	switch (checkInType) {
		case kCheckInTypeIBought:
			self.formattedValue = [NSString stringWithFormat:@"I Bought %@", symbol];
			break;
		case kCheckInTypeISold:
			self.formattedValue = [NSString stringWithFormat:@"I Sold %@", symbol];
			break;
		case kCheckinTypeGoodRumour:
			self.formattedValue = [NSString stringWithFormat:@"Good Rumour About %@?", symbol];
			break;
		case kCheckinTypeBadRumour:
			self.formattedValue = [NSString stringWithFormat:@"Bad Rumour About %@?", symbol];
			break;
		case kCheckInTypeImBullish:
			self.formattedValue = [NSString stringWithFormat:@"I am Bullish on %@", symbol];
			break;
		case kCheckInTypeImBearish:
			self.formattedValue = [NSString stringWithFormat:@"I am Bearish on %@", symbol];
			break;
		default:
			break;
	}
	
	return self.formattedValue;
}

- (void)dealloc {
	[_formattedValue release];
	[super dealloc];
}

@end
