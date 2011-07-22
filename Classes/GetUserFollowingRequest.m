//
//  GetUserFollowingRequest.m
//  Finster
//
//  Created by Todd Fearn on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetUserFollowingRequest.h"


@implementation GetUserFollowingRequest
@synthesize users = _users;

- (void)get:(NSString *)url {
	NSURL *nsurl = [NSURL URLWithString:url];
	[self setParseResponse:YES];	// Let's parse the JSON response
	[super get:nsurl];
}

- (NSObject *)getParsedDataObject {
	return self.users;
}

- (void)dealloc {
	[_users release];
	[super dealloc];
}

- (void)foundObject:(NSDictionary *)dict {
	MyLog(@"%@", dict);
	
	[_users release];
	_users = [[NSMutableArray alloc] init];
	
	NSArray *following = [dict objectForKey:@"following"];
	
	// Walk through the array and parse the dictionaries
	for(int i=0; i<[following count]; i++) {
		NSDictionary *userParentDict = [following objectAtIndex:i];
		NSDictionary *userDict = [userParentDict objectForKey:@"user"];
		
		User *user = [[User alloc] init];
		user.userID = [[userDict objectForKey:@"id"] stringValue];
		user.groupType = [userDict objectForKey:@"group"];
		user.userName = [userDict objectForKey:@"name"];
		user.imageUrl = [userDict objectForKey:@"image"];
		user.followers = [[userDict objectForKey:@"followers"] intValue];
		user.following = [[userDict objectForKey:@"following"] intValue];
		user.checkins = [[userDict objectForKey:@"checkins"] intValue];
		user.badges = [[userDict objectForKey:@"badges"] intValue];
		
		[self.users addObject:user];
		[user release];
	}
}

@end
