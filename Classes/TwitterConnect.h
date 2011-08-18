//
//  TwitterConnect.h
//  Finster
//
//  Created by Todd Fearn on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"
#import "SA_OAuthTwitterEngine.h"
#import "Globals.h"

@class TwitterConnect;

@protocol TwitterConnectDelegate <NSObject>
-(void)twitterConnectSucceeded;
-(void)twitterConnectFailed;
@end

@interface TwitterConnect : NSObject <SA_OAuthTwitterControllerDelegate> {
	id<TwitterConnectDelegate>			_delegate;
	SA_OAuthTwitterEngine				*_engine;
}
@property (assign) id<TwitterConnectDelegate> delegate;

- (BOOL)authorize:(UINavigationController *)navController;
- (BOOL)tweet:(NSString *)message;
	
@end
