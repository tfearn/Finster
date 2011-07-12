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
	
	MyLog(@"%@", dict);

	// Get the checkInList which is another dictionary
	NSArray *checkInList = [dict objectForKey:@"checkInList"];
	if(checkInList == nil)
		return;

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
	
	// Walk through the array and parse the dictionaries
	for(int i=0; i<[checkInList count]; i++) {
		NSDictionary *checkInDict = [checkInList objectAtIndex:i];
		
		CheckIn *checkIn = [[CheckIn alloc] init];
		checkIn.checkinID = [[checkInDict objectForKey:@"id"] longValue];
		NSString *timestamp = [checkInDict objectForKey:@"timestamp"];
		checkIn.timestamp = [dateFormatter dateFromString:timestamp];
		checkIn.checkinType = [[checkInDict objectForKey:@"type"] intValue];
		checkIn.comment = [checkInDict objectForKey:@"comment"];
		
		NSDictionary *user = [checkInDict objectForKey:@"user"];
		checkIn.user = [[User alloc] init];
		checkIn.user.userID = [user objectForKey:@"id"];
		checkIn.user.groupType = [user objectForKey:@"group"];
		checkIn.user.userName = [user objectForKey:@"name"];
		checkIn.user.imageUrl = [user objectForKey:@"image"];
		checkIn.user.followers = [[user objectForKey:@"followers"] intValue];
		checkIn.user.following = [[user objectForKey:@"following"] intValue];
		checkIn.user.checkins = [[user objectForKey:@"checkins"] intValue];
		checkIn.user.badges = [[user objectForKey:@"badges"] intValue];
		
		NSDictionary *ticker = [checkInDict objectForKey:@"ticker"];
		checkIn.ticker = [[Ticker alloc] init];
		checkIn.ticker.symbol = [ticker objectForKey:@"symbol"];
		checkIn.ticker.symbolName = [ticker objectForKey:@"symbolName"];
		checkIn.ticker.exchangeName = [ticker objectForKey:@"exchange"];
		checkIn.ticker.typeName = [ticker objectForKey:@"type"];
		
		[self.checkIns addObject:checkIn];
		[checkIn release];
	}
	
	[dateFormatter release];
}

@end
