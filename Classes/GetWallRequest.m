//
//  GetWallRequest.m
//  Finster
//
//  Created by Todd Fearn on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetWallRequest.h"

@implementation GetWallRequest
@synthesize checkIns = _checkIns;

- (void)get {
	[_checkIns release];
	_checkIns = [[NSMutableArray alloc] init];

	NSURL *url = [NSURL URLWithString:kUrlGetWall];
	[self setParseResponse:YES];	// Let's parse the JSON response
	[super get:url];
}

- (NSObject *)getParsedDataObject {
	return self.checkIns;
}

- (void)dealloc {
	[_checkIns release];
	[super dealloc];
}

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
	// empty
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {

	// Get the ResultSet which is another dictionary
	NSArray *checkInList = [dict objectForKey:@"checkInList"];
	if(checkInList == nil)
		return;

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss.s zzz"];
	
	// Walk through the array and parse the dictionaries
	for(int i=0; i<[checkInList count]; i++) {
		NSDictionary *checkInDict = [checkInList objectAtIndex:i];
		
		CheckIn *checkIn = [[CheckIn alloc] init];
		checkIn.checkinID = [[checkInDict objectForKey:@"id"] longValue];
		NSString *timestamp = [checkInDict objectForKey:@"timestamp"];
		checkIn.timestamp = [dateFormatter dateFromString:timestamp];
		NSString *checkInType = [checkInDict objectForKey:@"type"];
		if([checkInType isEqualToString:@"CheckInTypeIBought"])
			checkIn.checkinType = kCheckInTypeIBought;
		else if([checkInType isEqualToString:@"CheckInTypeISold"])
			checkIn.checkinType = kCheckInTypeISold;
		else if([checkInType isEqualToString:@"CheckInTypeImBullish"])
			checkIn.checkinType = kCheckInTypeImBullish;
		else if([checkInType isEqualToString:@"CheckInTypeImBearish"])
			checkIn.checkinType = kCheckInTypeImBearish;
		else if([checkInType isEqualToString:@"CheckinTypeShouldIBuy"])
			checkIn.checkinType = kCheckinTypeShouldIBuy;
		else if([checkInType isEqualToString:@"CheckInTypeShouldISell"])
			checkIn.checkinType = kCheckInTypeShouldISell;
		else if([checkInType isEqualToString:@"CheckInTypeImThinking"])
			checkIn.checkinType = kCheckInTypeImThinking;
		checkIn.comment = [checkInDict objectForKey:@"comment"];
		
		NSDictionary *user = [checkInDict objectForKey:@"user"];
		checkIn.user = [[User alloc] init];
		checkIn.user.userID = [user objectForKey:@"id"];
		checkIn.user.groupType = [user objectForKey:@"group"];
		checkIn.user.userName = [user objectForKey:@"name"];
		checkIn.user.imageUrl = [user objectForKey:@"image"];
		
		NSDictionary *ticker = [checkInDict objectForKey:@"ticker"];
		checkIn.ticker = [[Ticker alloc] init];
		checkIn.ticker.symbol = [ticker objectForKey:@"symbol"];
		checkIn.ticker.symbolName = [ticker objectForKey:@"symbolName"];
		checkIn.ticker.exchangeName = [ticker objectForKey:@"exchange"];
		checkIn.ticker.typeName = [ticker objectForKey:@"type"];
		
		[self.checkIns addObject:checkIn];
		[checkIn release];
	}
}

@end
