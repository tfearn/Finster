//
//  ProfileViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "BaseUserViewController.h"

@interface ProfileViewController : BaseUserViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
}

- (IBAction)feedbackButtonPressed:(id)sender;
- (IBAction)shareAppButtonPressed:(id)sender;

@end
