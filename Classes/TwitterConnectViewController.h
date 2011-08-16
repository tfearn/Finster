//
//  TwitterConnectViewController.h
//  Finster
//
//  Created by Todd Fearn on 8/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "BaseViewController.h"

@protocol TwitterConnectViewControllerDelegate <NSObject>
	-(void)twitterConnectComplete;
@end

@interface TwitterConnectViewController : BaseViewController <ASIHTTPRequestDelegate> {
	id<TwitterConnectViewControllerDelegate> _delegate;
	IBOutlet UITextField *_username;
	IBOutlet UITextField *_password;
	ASIHTTPRequest *_request;
	SBJSON *_jsonParser;
}
@property (assign) id<TwitterConnectViewControllerDelegate> delegate;
@property (nonatomic, retain) UITextField *username;
@property (nonatomic, retain) UITextField *password;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) SBJSON *jsonParser;

- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
