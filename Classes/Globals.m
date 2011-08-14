//
//  Globals.m
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Globals.h"

static NSString *lastTickerSearch;
static CSqliteDatabase *db;
static NSDate *lastNetworkError;


@implementation Globals

+ (void)initialize {
	lastTickerSearch = [[NSString alloc] init];
	lastNetworkError = [[NSDate alloc] init];
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

+ (void)showNetworkError:(NSError *)error {
	MyLog(@"Network Error: %@", [error description]);
	
	// Determine how many seconds has passed since the last network error.  If greater than ? then display the network
	// This reduces annoying network error popups for the user
	NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970] - [lastNetworkError timeIntervalSince1970];
	if(seconds > kMaxSecondsBetweenNetworkErrorMessages) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Cannot connect to the network" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
	}
	
	lastNetworkError = [NSDate date];
}

+ (void)logError:(NSError *)error name:(NSString *)name detail:(NSString *)detail {
	
	MyLog(@"Error: %@", [error description]);
	if(detail != nil) {
		MyLog(@"%@", detail);
		
		NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:detail, @"logError", nil];
		[FlurryAPI logEvent:name withParameters:errorDict timed:NO];
	}
}

@end