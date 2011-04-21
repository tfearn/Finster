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

- (void)doRequest {
	[_checkIns release];
	_checkIns = [[NSMutableArray alloc] init];

	NSURL *url = [NSURL URLWithString:kUrlGetWall];
	[super doRequest:url];
}

- (NSObject *)getParsedDataObject {
	return self.checkIns;
}

- (void)dealloc {
	[_checkIns release];
	[super dealloc];
}

#pragma mark XML Parsing

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	lastStartElement = elementName;
	
	if([elementName isEqualToString:@"checkin"]) {
		checkIn = [[CheckIn alloc] init];
	}
	else if([elementName isEqualToString:@"user"]) {
		checkIn.user = [[User alloc] init];
	}
	else if([elementName isEqualToString:@"ticker"]) {
		checkIn.ticker = [[Ticker alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"checkin"]) {
		[self.checkIns addObject:checkIn];
		[checkIn release];
		checkIn = nil;
	}
	
	lastStartElement = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

	// Strip line feeds
	NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
	string = trimmedString;
	if([string length] == 0)
		return;
	
	// CheckIn
	if([lastStartElement isEqualToString:@"id"]) {
		if(checkIn.user != nil)
			checkIn.user.userID = string;
		else
			checkIn.checkinID = string;
	}
	else if([lastStartElement isEqualToString:@"timestamp"]) {
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss.s zzz"];
		checkIn.timestamp = [dateFormatter dateFromString:string];
	}
	else if([lastStartElement isEqualToString:@"type"]) {
		if(checkIn.ticker != nil)
			checkIn.ticker.typeName = string;
		else {
			if([string isEqualToString:@"CheckInTypeIBought"])
				checkIn.checkinType = kCheckInTypeIBought;
			else if([string isEqualToString:@"CheckInTypeISold"])
				checkIn.checkinType = kCheckInTypeISold;
			else if([string isEqualToString:@"CheckInTypeImBullish"])
				checkIn.checkinType = kCheckInTypeImBullish;
			else if([string isEqualToString:@"CheckInTypeImBearish"])
				checkIn.checkinType = kCheckInTypeImBearish;
			else if([string isEqualToString:@"CheckinTypeShouldIBuy"])
				checkIn.checkinType = kCheckinTypeShouldIBuy;
			else if([string isEqualToString:@"CheckInTypeShouldISell"])
				checkIn.checkinType = kCheckInTypeShouldISell;
			else if([string isEqualToString:@"CheckInTypeImThinking"])
				checkIn.checkinType = kCheckInTypeImThinking;
		}
	}
	if([lastStartElement isEqualToString:@"comment"]) {
		checkIn.comment = string;
	}
		
	// User
	else if([lastStartElement isEqualToString:@"group"]) {
		if(checkIn.user != nil)
			checkIn.user.groupType = string;
	}
	else if([lastStartElement isEqualToString:@"name"]) {
		if(checkIn.user != nil)
			checkIn.user.userName = string;
	}
	else if([lastStartElement isEqualToString:@"image"]) {
		if(checkIn.user != nil)
			checkIn.user.imageUrl = [NSURL URLWithString:string];
	}
		
	// Ticker
	else if([lastStartElement isEqualToString:@"symbol"]) {
		if(checkIn.ticker != nil)
			checkIn.ticker.symbol = string;
	}
	else if([lastStartElement isEqualToString:@"symbolName"]) {
		if(checkIn.ticker != nil)
			checkIn.ticker.symbolName = string;
	}
	else if([lastStartElement isEqualToString:@"exchange"]) {
		if(checkIn.ticker != nil)
			checkIn.ticker.exchangeName = string;
	}
}

@end
