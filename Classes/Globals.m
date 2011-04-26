//
//  Globals.m
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Globals.h"

static NSString *username;
static NSString *password;
static NSString *lastTickerSearch;


@implementation Globals

+ (void)initialize {
	username = [[NSString alloc] init];
	password = [[NSString alloc] init];
	lastTickerSearch = [[NSString alloc] init];
}

+ (NSString *)getUsername {
	return username;
}

+ (void)setUsername:(NSString *)newUsername {
	[username release];
	username = [newUsername retain];
}

+ (NSString *)getPassword {
	return password;
}

+ (void)setPassword:(NSString *)newPassword {
	[password release];
	password = [newPassword retain];
}

+ (NSString *)getLastTickerSearch {
	return lastTickerSearch;
}

+ (void)setLastTickerSearch:(NSString *)newLastTickerSearch {
	[lastTickerSearch release];
	lastTickerSearch = [newLastTickerSearch retain];
}

@end