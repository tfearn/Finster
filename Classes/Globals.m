//
//  Globals.m
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Globals.h"


static NSString *lastTickerSearch;


@implementation Globals

+ (void)initialize {
	lastTickerSearch = [[NSString alloc] init];
}

+ (NSString *)getLastTickerSearch {
	return lastTickerSearch;
}

+ (void)setLastTickerSearch:(NSString *)newLastTickerSearch {
	[lastTickerSearch release];
	lastTickerSearch = [newLastTickerSearch retain];
}

@end