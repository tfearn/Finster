//
//  DbSearchedTickerInsert.h
//  Finster
//
//  Created by Todd Fearn on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSqliteDatabase.h"
#import "Globals.h"
#import "Ticker.h"

#define kSqlInsertSearchedTicker		@"INSERT INTO searched_ticker (symbol, symbol_name, type, type_name, exchange, exchange_name) VALUES ('%@', '%@', '%@', '%@', '%@', '%@')"

@interface DbSearchedTickerInsert : NSObject {
}

+ (NSError *)doInsert:(Ticker *)ticker;

@end
