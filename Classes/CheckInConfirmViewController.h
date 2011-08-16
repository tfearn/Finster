//
//  CheckInConfirmViewController.h
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlurryAPI.h"
#import "BaseCheckInViewController.h"
#import "CheckInResultViewController.h"
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "CheckInResult.h"
#import "TwitterConnectViewController.h"

@interface CheckInConfirmViewController : BaseCheckInViewController <UITextViewDelegate, ASIHTTPRequestDelegate, TwitterConnectViewControllerDelegate> {
	IBOutlet UITextView *_textView;
	IBOutlet UIImageView *_facebookImageView;
	IBOutlet UIImageView *_twitterImageView;
	IBOutlet UIButton *_facebookButton;
	IBOutlet UIButton *_twitterButton;
	ASIHTTPRequest *_request;
	SBJSON *_jsonParser;
	BOOL commentExists;
	BOOL facebookOn;
	BOOL twitterOn;
}
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UIImageView *facebookImageView;
@property (nonatomic, retain) UIImageView *twitterImageView;
@property (nonatomic, retain) UIButton *facebookButton;
@property (nonatomic, retain) UIButton *twitterButton;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) SBJSON *jsonParser;

- (IBAction)facebookButtonPressed:(id)sender;
- (IBAction)twitterButtonPressed:(id)sender;
- (IBAction)checkInButtonPressed:(id)sender;

@end
