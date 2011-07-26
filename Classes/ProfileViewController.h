//
//  ProfileViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "Globals.h"
#import "ImageManager.h"
#import "BaseViewController.h"
#import "User.h"
#import "UserViewController.h"

@interface ProfileViewController : BaseViewController <ASIHTTPRequestDelegate, ImageManagerDelegate, UIActionSheetDelegate> {
	IBOutlet UITableView *_tableView;
	IBOutlet UIButton *_buttonShareApp;
	IBOutlet UIButton *_buttonFindFriends;
	ASIHTTPRequest *_request;
	ImageManager *_imageManager;
	NSMutableArray *_users;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIButton *buttonShareApp;
@property (nonatomic, retain) UIButton *buttonFindFriends;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) ImageManager *imageManager;
@property (nonatomic, retain) NSMutableArray *users;

- (IBAction)feedbackButtonPressed:(id)sender;
- (IBAction)shareAppButtonPressed:(id)sender;
- (IBAction)findFriendsButtonPressed:(id)sender;

@end
