//
//  TimePassedFormatter.m
//  Finster
//
//  Created by Todd Fearn on 5/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimePassedFormatter.h"


@implementation TimePassedFormatter
@synthesize formattedValue = _formattedValue;

- (id)init {
    if (self = [super init]) {
		_formattedValue = [[NSString alloc] init];
    }
    return self;
}

- (NSString *)format:(NSDate *)date {
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
			self.formattedValue = [NSString stringWithFormat:@"%d months ago", months];
		else
			self.formattedValue = [NSString stringWithFormat:@"%d month ago", months];
	}
	else if(days > 0) {
		if(days > 1)
			self.formattedValue = [NSString stringWithFormat:@"%d days ago", days];
		else
			self.formattedValue = [NSString stringWithFormat:@"%d day ago", days];
	}
	else if(hours > 0) {
		if(hours > 1)
			self.formattedValue = [NSString stringWithFormat:@"%d hours ago", hours];
		else
			self.formattedValue = [NSString stringWithFormat:@"%d hour ago", hours];
	}
	else if(minutes > 0) {
		if(minutes > 1)
			self.formattedValue = [NSString stringWithFormat:@"%d minutes ago", minutes];
		else
			self.formattedValue= [NSString stringWithFormat:@"%d minute ago", minutes];
	}
	else {
		self.formattedValue = @"a moment ago";
	}
	
	return self.formattedValue;
}

- (void)dealloc {
	[_formattedValue release];
	[super dealloc];
}

@end
