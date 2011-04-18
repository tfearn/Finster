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

@interface CheckInConfirmViewController : BaseCheckInViewController <UITextViewDelegate> {
	IBOutlet UITextView *_textView;
	IBOutlet UIImageView *_facebookImageView;
	IBOutlet UIImageView *_twitterImageView;
	IBOutlet UIButton *_facebookButton;
	IBOutlet UIButton *_twitterButton;
	BOOL commentExists;
	BOOL facebookOn;
	BOOL twitterOn;
}
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UIImageView *facebookImageView;
@property (nonatomic, retain) UIImageView *twitterImageView;
@property (nonatomic, retain) UIButton *facebookButton;
@property (nonatomic, retain) UIButton *twitterButton;

- (IBAction)facebookButtonPressed:(id)sender;
- (IBAction)twitterButtonPressed:(id)sender;
- (IBAction)checkInButtonPressed:(id)sender;

@end
