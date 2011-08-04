//
//  Ticker.h
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Ticker : NSObject {
	NSString *_symbol;
	NSString *_symbolName;
	NSString *_type;			// The type code
	NSString *_typeName;		// Equity, Option, etc.
	NSString *_exchange;		// The exchange short code
	NSString *_exchangeName;	// NYSE, NASDAQ, etc.
}
@property (nonatomic, retain) NSString *symbol;
@property (nonatomic, retain) NSString *symbolName;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *typeName;
@property (nonatomic, retain) NSString *exchange;
@property (nonatomic, retain) NSString *exchangeName;

- (void)assignValuesFromDictionary:(NSDictionary *)dict;

@end
