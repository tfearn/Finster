//
//  DbSearchedTickerGet.m
//  Finster
//
//  Created by Todd Fearn on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DbSearchedTickerGet.h"


@implementation DbSearchedTickerGet
@synthesize tickers = _tickers;

- (NSError *)doSelect {
	CSqliteDatabase *dbHandle = [Globals getDatabaseHandle];
	
	NSString *select = kSelectGetSearchedTickers;
	
	NSError *error = nil;
    NSArray *rows = [dbHandle rowsForExpression:select error:&error];
	if(error != nil)
		return error;
	
	[_tickers release];
	self.tickers = [[NSMutableArray alloc] init];
    for (NSDictionary *row in rows) {
        Ticker *ticker = [[Ticker alloc] init];
		
		ticker.symbol = [row objectForKey:@"symbol"];
		ticker.symbolName = [row objectForKey:@"symbol_name"];
		ticker.type = [row objectForKey:@"type"];
		ticker.typeName = [row objectForKey:@"type_name"];
		ticker.exchange = [row objectForKey:@"exchange"];
		ticker.exchangeName = [row objectForKey:@"exchange_name"];
		
        [self.tickers addObject:ticker];
        [ticker release];
    }
	
	return nil;
}

- (void)dealloc {
	[_tickers release];
	[super dealloc];
}

@end
