//
//  Globals.h
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Check In Types
#define kCheckInTypeBoughtAStock	1
#define kCheckInTypeSoldAStock		2

// URLs
#define kUrlTickerLookup			@"http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=%@&callback=YAHOO.Finance.SymbolSuggest.ssCallback"

@interface Globals : NSObject {

}

@end
