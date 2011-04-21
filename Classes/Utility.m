//
//  Utility.m
//  Finster
//
//  Created by Todd Fearn on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"


@implementation Utility

+ (NSString *)getCheckInString:(NSString *)string checkInType:(int)checkInType symbol:(NSString *)symbol {
	
	switch (checkInType) {
		case kCheckInTypeIBought:
			string = [NSString stringWithFormat:@"You Bought %@", symbol];
			break;
		case kCheckInTypeISold:
			string = [NSString stringWithFormat:@"You Sold %@", symbol];
			break;
		case kCheckinTypeShouldIBuy:
			string = [NSString stringWithFormat:@"Should I Buy %@?", symbol];
			break;
		case kCheckInTypeShouldISell:
			string = [NSString stringWithFormat:@"Should I Sell %@?", symbol];
			break;
		case kCheckInTypeImBullish:
			string = [NSString stringWithFormat:@"I am Bullish on %@", symbol];
			break;
		case kCheckInTypeImBearish:
			string = [NSString stringWithFormat:@"I am Bearish on %@", symbol];
			break;
		case kCheckInTypeImThinking:
			string = [NSString stringWithFormat:@"My Thoughts on %@", symbol];
			break;
		default:
			break;
	}
	
	return string;
}

@end
