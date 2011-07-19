//
//  Globals.h
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSqliteDatabase.h"

// Check In Types
#define kCheckInTypeIBought			1
#define kCheckInTypeISold			2
#define kCheckInTypeImBullish		3
#define kCheckInTypeImBearish		4
#define kCheckinTypeGoodRumour		5
#define kCheckinTypeBadRumour		6

// Keys
#define kUsernameKey				@"username"
#define kPasswordKey				@"password"
#define kFacebookAccessTokenKey		@"facebook_access_token"
#define kFacebookExpirationDateKey	@"facebook_expiration_date"

// URLs
#define kUrlLogin					@"http://173.203.238.148/cgi-bin/login.cgi"			// No longer used
#define kUrlLoginUsingFacebook		@"http://209.114.35.245/loginUsingFacebook?facebookuserid=%@&accesstoken=%@"
#define kUrlTickerLookup			@"http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=%@&callback=YAHOO.Finance.SymbolSuggest.ssCallback"
#define kUrlGetWall					@"http://209.114.35.245/getcheckins?feed=you&start=0&limit=20"
#define kUrlGetActivity				@"http://209.114.35.245/getcheckins?feed=network&start=0&limit=20"
#define kUrlPostCheckIn				@"http://209.114.35.245/checkin?type=%d&symbol=%@&symbolName=%@&symbolType=%@&exchange=%@"
#define kUrlGetUser					@"http://209.114.35.245/getuser?user=%@"
#define kUrlFollowUser				@"http://209.114.35.245/followuser?userid=%@"
#define kUrlGetCheckInsByTicker		@"http://209.114.35.245/getcheckins?feed=network&start=0&limit=20&ticker=%@"

// Notifications
#define kNotificationCheckInComplete	@"NotificationCheckInComplete"

// Other defines
#define kDatabaseFilename			@"finster.sqlite"

// Macros
#ifndef NDEBUG
#define MyLog(s, ... ) NSLog(@"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define MyLog( s, ... )
#endif

@interface Globals : NSObject {

}

+ (NSString *)getUsername;
+ (void)setUsername:(NSString *)newUsername;
+ (NSString *)getPassword;
+ (void)setPassword:(NSString *)newPassword;
+ (NSString *)getLastTickerSearch;
+ (void)setLastTickerSearch:(NSString *)newLastTickerSearch;
+ (NSError *)openDatabase:(NSString *)filename;
+ (CSqliteDatabase *)getDatabaseHandle;

@end
