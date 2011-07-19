//
//  CheckInRequest.m
//  Finster
//
//  Created by Todd Fearn on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInRequest.h"


@implementation CheckInRequest

- (void)get:(NSString *)url {
	NSURL *nsurl = [NSURL URLWithString:url];
	[self setParseResponse:YES];	// Let's parse the JSON response
	[super get:nsurl];
}

- (NSObject *)getParsedDataObject {
	return self;
}

- (void)dealloc {
	[super dealloc];
}

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
	// empty
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
	
	MyLog(@"%@", dict);
}

@end
