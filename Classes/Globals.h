//
//  Globals.h
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Check In Types
#define kCheckInTypeIBought			1
#define kCheckInTypeISold			2
#define kCheckInTypeImBullish		3
#define kCheckInTypeImBearish		4
#define kCheckinTypeShouldIBuy		5
#define kCheckInTypeShouldISell		6
#define kCheckInTypeImThinking		7

// URLs
#define kUrlTickerLookup			@"http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=%@&callback=YAHOO.Finance.SymbolSuggest.ssCallback"
#define kUrlGetWall					@"http://www.idata.net/finster/wall2.xml"
//#define kUrlGetWall					@"https://hostname/getcheckins.cgi?start=1&limit=20&feed=you+wall&type=CheckInTypeAll&ticker=all"

// Notifications
#define kNotificationCheckInComplete	@"NotificationCheckInComplete"

// Macros
#ifndef NDEBUG
#define MyLog(s, ... ) NSLog(@"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define MyLog( s, ... )
#endif

@interface Globals : NSObject {

}

+ (NSString *)getLastTickerSearch;
+ (void)setLastTickerSearch:(NSString *)newLastTickerSearch;
	

@end
