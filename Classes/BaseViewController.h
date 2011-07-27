//
//  BaseViewController.h
//  HedgeHog
//
//  Created by Todd Fearn on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Globals.h"
#import "WaitView.h"

@interface BaseViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    WaitView *_waitView;
	BOOL _showShareAppButton;
}
@property (nonatomic, readonly) WaitView *waitView;
@property BOOL showShareAppButton;

- (void)showWaitView:(NSString *)message;
- (void)dismissWaitView;

- (IBAction)shareAppButtonPressed:(id)sender;

@end
