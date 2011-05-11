//
//  DbSearchedTickerGet.h
//  Finster
//
//  Created by Todd Fearn on 4/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSqliteDatabase.h"
#import "Globals.h"
#import "Ticker.h"

#define kSelectGetSearchedTickers				@"SELECT * FROM searched_ticker GROUP BY symbol ORDER BY timestamp desc limit 10;"

@interface DbSearchedTickerGet : NSObject {
	NSMutableArray *_tickers;
}
@property (nonatomic, retain) NSMutableArray *tickers;

- (NSError *)doSelect;

@end
