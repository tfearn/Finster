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

- (id)init {
    if (self = [super init]) {
		_user = [[User alloc] init];
		_ticker = [[Ticker alloc] init];
    }
    return self;
}

- (void)assignValuesFromDictionary:(NSDictionary *)dict {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	
	self.checkinID = [[dict objectForKey:@"id"] longValue];
	NSString *timestamp = [dict objectForKey:@"timestamp"];
	self.timestamp = [dateFormatter dateFromString:timestamp];
	id object;
	if((object = [Utility objectNotNSNull:[dict objectForKey:@"type"]]) != nil)
		self.checkinType = [object intValue];
	self.comment = [dict objectForKey:@"comment"];
	
	[dateFormatter release];
}

- (void)dealloc {
	[_timestamp release];
	[_user release];
	[_ticker release];
	[_comment release];
	[super dealloc];
}

@end
