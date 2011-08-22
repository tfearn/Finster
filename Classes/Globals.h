//
//  Globals.h
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSqliteDatabase.h"
#import "FlurryAPI.h"

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
#define kFacebookAppID				@"155491054528323"
#define kFacebookAccessTokenKey		@"FBAccessTokenKey"
#define kFacebookExpirationDateKey	@"FBExpirationDateKey"

// EMail addresses
#define kEmailFinsterFeedback		@"admin@finster.mobi"

// URLs
#define kUrlTickerLookup			@"http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=%@&callback=YAHOO.Finance.SymbolSuggest.ssCallback"
#define kUrlLoginUsingFacebook		@"http://developer.finster.mobi/api/loginUsingFacebook?facebookuserid=%@&accesstoken=%@"
#define kUrlGetCheckInsYouFriends	@"http://developer.finster.mobi/api/getcheckins?feed=you,friends&start=0&limit=40"
#define kUrlGetCheckInsNetwork		@"http://developer.finster.mobi/api/getcheckins?feed=network&start=0&limit=20"
#define kUrlGetCheckInsByTicker		@"http://developer.finster.mobi/api/getcheckins?ticker=%@"
#define kUrlGetCheckInsByUser		@"http://developer.finster.mobi/api/getcheckins?feed=user&userid=%@"
#define kUrlPostCheckIn				@"http://developer.finster.mobi/api/checkin?type=%d&symbol=%@&symbolName=%@&symbolType=%@"
#define kUrlGetUser					@"http://developer.finster.mobi/api/getuser"
#define kUrlFollowUser				@"http://developer.finster.mobi/api/followuser?userid=%@"
#define kUrlUnFollowUser			@"http://developer.finster.mobi/api/unfollowuser?userid=%@"
#define kUrlIsFollowingUser			@"http://developer.finster.mobi/api/isfollowinguser?userid=%@"
#define kUrlGetUserFollowing		@"http://developer.finster.mobi/api/getuserfollowing"
#define kUrlGetUserFollowers		@"http://developer.finster.mobi/api/getuserfollowers"
#define kUrlGetUserLastCheckins		@"http://developer.finster.mobi/api/getuserlastcheckins"
#define kUrlGetTrending				@"http://developer.finster.mobi/api/gettrending?start=0&limit=20"
#define kUrlFindUser				@"http://developer.finster.mobi/api/finduser?search=%@"
#define kUrlTwitterConnect			@"http://developer.finster.mobi/api/twitterconnect?username=%@&password=%@"
#define kUrlGetLeaderboard			@"http://developer.finster.mobi/api/getleaderboard"

// Maximum rows retrieved for all getcheckins REST calls
#define kMaxRowsForGetCheckIns		50

// The number of seconds the application will be delayed upon startup.  This is used to display the splash screen for a longer time.
#define kStartupDelay				1.0

// Notifications
#define kNotificationCheckInComplete	@"NotificationCheckInComplete"

// Twitter
#define kTwitterOAuthConsumerKey		@"V6I9EVAHee2PN9UzUdzYnA"
#define kTwitterOAuthConsumerSecret		@"SXZJg9jspz39i6Y7W8yr5kD41ZIPWiWLDRTj1ElmEc"
#define kTwitterOAuthData				@"authData"

// Other defines
#define kDatabaseFilename						@"finster.sqlite"
#define kMaxSecondsBetweenNetworkErrorMessages	60.0

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
+ (NSError *)openDatabase:(NSString *)filename;
+ (CSqliteDatabase *)getDatabaseHandle;
+ (void)logError:(NSError *)error name:(NSString *)name detail:(NSString *)detail;
+ (BOOL)isTwitterConfigured;
+ (NSString *) getTwitterOAuthData;

@end
