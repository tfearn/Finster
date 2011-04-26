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
static CSqliteDatabase *db;


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

+ (NSError *)openDatabase:(NSString *)filename {
	
	// Close the existing database if open
	if(db != nil) {
		[db close];
		[db release];
		db = nil;
	}
	
	db = [[CSqliteDatabase alloc] initWithPath:filename];
	
    // Open DB
    NSError *error = nil;
    [db open:&error];
	if(error != nil)
		return error;
	
	return nil;
}

+ (CSqliteDatabase *)getDatabaseHandle {
	return db;
}



@end