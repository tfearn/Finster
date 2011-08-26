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
	
	// Initialize the last network error date to now - 120 seconds so the initial
	// network error will show if triggered at startup
	lastNetworkError = [[NSDate alloc] initWithTimeIntervalSinceNow:-120];
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

+ (void)logError:(NSError *)error name:(NSString *)name detail:(NSString *)detail {
	
	MyLog(@"Error: %@", [error description]);
	if(detail != nil) {
		MyLog(@"%@", detail);
		
		// Log to Flurry only for a release version
#ifdef NDEBUG
		NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:detail, @"logError", nil];
		[FlurryAPI logEvent:name withParameters:errorDict timed:NO];
#endif
	}
}

+ (BOOL)isTwitterConfigured {
	NSObject *data = [[NSUserDefaults standardUserDefaults] objectForKey:kTwitterOAuthData];
	if(data != nil)
		return YES;
	return NO;
}

+ (NSString *) getTwitterOAuthData {
	return [[NSUserDefaults standardUserDefaults] objectForKey:kTwitterOAuthData];
}

+ (BOOL)showNetworkError {
	// Determine how many seconds has passed since the last network error.  If greater than ? then display the network
	// This reduces annoying network error popups for the user
	NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970] - [lastNetworkError timeIntervalSince1970];
	if(seconds > kMaxSecondsBetweenNetworkErrorMessages) {
		lastNetworkError = [NSDate date];
		return YES;
	}
	
	return NO;
}

@end