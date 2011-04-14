//
//  Ticker.m
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Ticker.h"


@implementation Ticker
@synthesize symbol = _symbol;
@synthesize symbolName = _symbolName;
@synthesize type = _type;
@synthesize typeName = _typeName;
@synthesize exchange = _exchange;
@synthesize exchangeName = _exchangeName;


- (void)dealloc {
	[_symbol release];
	[_symbolName release];
	[_type release];
	[_typeName release];
	[_exchange release];
	[_exchangeName release];
	[super dealloc];
}

@end
