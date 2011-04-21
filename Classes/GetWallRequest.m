//
//  GetWallRequest.m
//  Finster
//
//  Created by Todd Fearn on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetWallRequest.h"

@interface GetWallRequest (Private)
- (void)parseData:(NSData *)data;
@end


@implementation GetWallRequest
@synthesize delegate;
@synthesize request = _request;
@synthesize error = _error;
@synthesize checkIns = _checkIns;

- (void)doRequest {
	NSURL *url = [NSURL URLWithString:kUrlGetWall];
	_request = [ASIHTTPRequest requestWithURL:url];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
}

- (void)dealloc {
	if(self.request != nil)
		[self.request clearDelegatesAndCancel];
	
	[_request release];
	[_error release];
	[_checkIns release];
	[super dealloc];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	[_checkIns release];
	_checkIns = [[NSMutableArray alloc] init];
	
	// Parse the return data
	[self parseData:[request responseData]];

	 // Call the delegate
	 if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(getWallRequestComplete:)]) {
		 [self.delegate getWallRequestComplete:self];
	 }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	self.error = [request error];
	
	// Call the delegate
	if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(getWallRequestFailure:)]) {
		[self.delegate getWallRequestFailure:self];
	}
}

#pragma mark XML Parsing

- (void)parseData:(NSData *)data {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	
    [parser setDelegate:self]; // The parser calls methods in this class
    [parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
    [parser setShouldReportNamespacePrefixes:NO]; 
    [parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
	
    [parser parse]; // Parse that data..
	[parser release];
}

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
			if([string caseInsensitiveCompare:@"CheckInTypeBought"])
				checkIn.checkinType = kCheckInTypeBought;
			else if([string caseInsensitiveCompare:@"CheckInTypeSold"])
				checkIn.checkinType = kCheckInTypeSold;
			else if([string caseInsensitiveCompare:@"CheckInTypeImBullish"])
				checkIn.checkinType = kCheckInTypeImBullish;
			else if([string caseInsensitiveCompare:@"CheckInTypeImBearish"])
				checkIn.checkinType = kCheckInTypeImBearish;
			else if([string caseInsensitiveCompare:@"CheckinTypeShouldIBuy"])
				checkIn.checkinType = kCheckinTypeShouldIBuy;
			else if([string caseInsensitiveCompare:@"CheckInTypeShouldISell"])
				checkIn.checkinType = kCheckInTypeShouldISell;
			else if([string caseInsensitiveCompare:@"CheckInTypeImThinking"])
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
