    //
//  TwitterConnect.m
//  Finster
//
//  Created by Todd Fearn on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterConnect.h"

@implementation TwitterConnect
@synthesize delegate = _delegate;

#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject:data forKey:kTwitterOAuthData];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey:kTwitterOAuthData];
}

#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	MyLog(@"Twitter authenicated for %@", username);

	// Call the delegate
	if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(twitterConnectSucceeded)]) {
		[self.delegate twitterConnectSucceeded];
	}
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	MyLog(@"Twitter authentication Failed!");

	// Call the delegate
	if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(twitterConnectFailed:)]) {
		[self.delegate twitterConnectFailed];
	}
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
}

#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	MyLog(@"Request %@ succeeded", requestIdentifier);
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	MyLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}

#pragma mark ViewController Stuff
- (void)dealloc {
	[_engine release];
    [super dealloc];
}

- (BOOL)connectWithTwitter:(UINavigationController *)navController {
	[_engine release];
	_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
	_engine.consumerKey = kTwitterOAuthConsumerKey;
	_engine.consumerSecret = kTwitterOAuthConsumerSecret;
	
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
	
	if (controller) {
		[navController presentModalViewController: controller animated: YES];
		return YES;
	}
	else {
		[_engine sendUpdate: [NSString stringWithFormat: @"Already Updated. %@", [NSDate date]]];
		return NO;
	}
}

@end
