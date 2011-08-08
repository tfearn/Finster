//
//  DbSearchedTickerInsert.m
//  Finster
//
//  Created by Todd Fearn on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DbSearchedTickerInsert.h"


@implementation DbSearchedTickerInsert

+ (NSError *)doInsert:(Ticker *)ticker {
	
	CSqliteDatabase *dbHandle = [Globals getDatabaseHandle];
	
	NSString *exchangeName = @"";
	if(ticker.exchangeName != nil)
		exchangeName = ticker.exchangeName;

	NSString *insert =  [NSString stringWithFormat:kSqlInsertSearchedTicker, ticker.symbol, ticker.symbolName, ticker.type, ticker.typeName, ticker.exchange, exchangeName];
	NSError *error = nil;
    if(! [dbHandle executeExpression:insert error:&error])
		return error;
	
	return nil;
}

@end
