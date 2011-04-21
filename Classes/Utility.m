//
//  Utility.m
//  Finster
//
//  Created by Todd Fearn on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"


@implementation Utility

+ (NSString *)getCheckInString:(int)checkInType symbol:(NSString *)symbol {
	
	NSString *checkInString = nil;
	
	switch (checkInType) {
		case kCheckInTypeBought:
			checkInString = [NSString stringWithFormat:@"You Bought %@", symbol];
			break;
		case kCheckInTypeSold:
			checkInString = [NSString stringWithFormat:@"You Sold %@", symbol];
			break;
		case kCheckinTypeShouldIBuy:
			checkInString = [NSString stringWithFormat:@"Should I Buy %@?", symbol];
			break;
		case kCheckInTypeShouldISell:
			checkInString = [NSString stringWithFormat:@"Should I Sell %@?", symbol];
			break;
		case kCheckInTypeImBullish:
			checkInString = [NSString stringWithFormat:@"I am Bullish on %@", symbol];
			break;
		case kCheckInTypeImBearish:
			checkInString = [NSString stringWithFormat:@"I am Bearish on %@", symbol];
			break;
		case kCheckInTypeImThinking:
			checkInString = [NSString stringWithFormat:@"My Thoughts on %@", symbol];
			break;
		default:
			break;
	}
	
	return checkInString;
}

@end
