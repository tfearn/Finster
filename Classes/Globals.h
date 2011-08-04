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
#define kFacebookAppID				@"215815565097885"
#define kFacebookAccessTokenKey		@"FBAccessTokenKey"
#define kFacebookExpirationDateKey	@"FBExpirationDateKey"

// EMail addresses
#define kEmailFinsterFeedback		@"tfearn@gmail.com"

// URLs
#define kUrlTickerLookup			@"http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=%@&callback=YAHOO.Finance.SymbolSuggest.ssCallback"
#define kUrlLoginUsingFacebook		@"http://finster.mobi/api/loginUsingFacebook?facebookuserid=%@&accesstoken=%@"
#define kUrlGetWall					@"http://finster.mobi/api/getcheckins?feed=you,friends"
#define kUrlGetActivity				@"http://finster.mobi/api/getcheckins?feed=network"
#define kUrlGetCheckInsByTicker		@"http://finster.mobi/api/getcheckins?feed=network&ticker=%@"
#define kUrlGetCheckInsByUser		@"http://finster.mobi/api/getcheckins?feed=user&userid=%@"
#define kUrlPostCheckIn				@"http://finster.mobi/api/checkin?type=%d&symbol=%@&symbolName=%@&symbolType=%@"
#define kUrlGetUser					@"http://finster.mobi/api/getuser"
#define kUrlFollowUser				@"http://finster.mobi/api/followuser?userid=%@"
#define kUrlUnFollowUser			@"http://finster.mobi/api/unfollowuser?userid=%@"
#define kUrlIsFollowingUser			@"http://finster.mobi/api/isfollowinguser?userid=%@"
#define kUrlGetUserFollowing		@"http://finster.mobi/api/getuserfollowing"
#define kUrlGetUserFollowers		@"http://finster.mobi/api/getuserfollowers"
#define kUrlGetTrending				@"http://finster.mobi/api/gettrending?start=0&limit=20"
#define kUrlFindUser				@"http://finster.mobi/api/finduser?search=%@"

// Maximum rows retrieved for all getcheckins REST calls
#define kMaxRowsForGetCheckIns		50

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
