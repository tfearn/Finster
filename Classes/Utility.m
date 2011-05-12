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

+ (NSString *)getDateAsTimePassed:(NSDate *)date {
	NSString *string = [[NSString alloc] init];
	
	NSCalendar *sysCalendar = [NSCalendar currentCalendar];
	NSDate *now = [[[NSDate alloc] init] autorelease];

    // Determine months, days, etc.
	unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
	NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:date  toDate:now  options:0];
	int months = [breakdownInfo month];
	int days = [breakdownInfo day];
	int hours = [breakdownInfo hour];
	int minutes = [breakdownInfo minute];
	
	if(months > 0) {
		if(months > 1)
			string = [NSString stringWithFormat:@"%d months ago", months];
		else
			string = [NSString stringWithFormat:@"%d month ago", months];
	}
	else if(days > 0) {
		if(days > 1)
			string = [NSString stringWithFormat:@"%d days ago", days];
		else
			string = [NSString stringWithFormat:@"%d day ago", days];
	}
	else if(hours > 0) {
		if(hours > 1)
			string = [NSString stringWithFormat:@"%d hours ago", hours];
		else
			string = [NSString stringWithFormat:@"%d hour ago", hours];
	}
	else if(minutes > 0) {
		if(minutes > 1)
			string = [NSString stringWithFormat:@"%d minutes ago", minutes];
		else
			string= [NSString stringWithFormat:@"%d minute ago", minutes];
	}
	else {
		string = @"just a moment ago";
	}
	
	return string;
}

@end
