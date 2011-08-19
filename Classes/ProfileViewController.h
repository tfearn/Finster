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
#import "FindFriendsOnAppViewController.h"

@interface ProfileViewController : BaseUserViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
	IBOutlet UIScrollView *_scrollView;
	IBOutlet UIButton *_findFriendsButton;
	UIActionSheet *_shareAppActionSheet;
	UIActionSheet *_findFriendsActionSheet;
}
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIButton *findFriendsButton;
@property (nonatomic, retain) UIActionSheet *shareAppActionSheet;
@property (nonatomic, retain) UIActionSheet *findFriendsActionSheet;

- (IBAction)feedbackButtonPressed:(id)sender;
- (IBAction)shareAppButtonPressed:(id)sender;
- (IBAction)findFriendsButtonPressed:(id)sender;

@end
