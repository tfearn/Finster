//
//  CheckInConfirmViewController.h
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCheckInViewController.h"
#import "CheckInResultViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "CheckInResult.h"

@interface CheckInConfirmViewController : BaseCheckInViewController <UITextViewDelegate, ASIHTTPRequestDelegate> {
	IBOutlet UITextView *_textView;
	IBOutlet UIImageView *_facebookImageView;
	IBOutlet UISwitch *_facebookSwitch;
	ASIHTTPRequest *_request;
	SBJSON *_jsonParser;
	BOOL commentExists;
	BOOL facebookOn;
	BOOL twitterOn;
}
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UIImageView *facebookImageView;
@property (nonatomic, retain) UISwitch *facebookSwitch;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) SBJSON *jsonParser;

- (IBAction)facebookSwitchPressed:(id)sender;
- (IBAction)checkInButtonPressed:(id)sender;

@end
