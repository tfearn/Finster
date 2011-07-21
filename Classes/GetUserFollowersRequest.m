//
//  GetUserFollowersRequest.m
//  Finster
//
//  Created by Todd Fearn on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetUserFollowersRequest.h"


@implementation GetUserFollowersRequest
@synthesize users = _users;

- (void)get:(NSString *)url {
	NSURL *nsurl = [NSURL URLWithString:url];
	[self setParseResponse:YES];	// Let's parse the JSON response
	[super get:nsurl];
}

- (NSObject *)getParsedDataObject {
	return self;
}

- (void)dealloc {
	[_users release];
	[super dealloc];
}

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
	// empty
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
	MyLog(@"%@", dict);
	
	[_users release];
	_users = [[NSMutableArray alloc] init];
	
	NSArray *userList = [dict objectForKey:@"users"];
	if(userList == nil)
		return;
	
	// Walk through the array and parse the dictionaries
	for(int i=0; i<[userList count]; i++) {
		NSDictionary *userDict = [userList objectAtIndex:i];
	}
}

@end
