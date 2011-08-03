//
//  Trend.h
//  Finster
//
//  Created by Todd Fearn on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ticker.h"

@interface Trend : NSObject {
	Ticker *_ticker;
	long _checkins;
	long _positive;
	long _negative;
}
@property (nonatomic, retain) Ticker *ticker;
@property long checkins;
@property long positive;
@property long negative;

@end
