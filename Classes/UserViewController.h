//
//  UserViewController.h
//  Finster
//
//  Created by Todd Fearn on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "User.h"
#import "BaseViewController.h"

@interface UserViewController : BaseViewController <ASIHTTPRequestDelegate> {
	User *_user;
	ASIHTTPRequest *_request;
	IBOutlet UIImageView *_userImageView;
	IBOutlet UILabel *_username;
	IBOutlet UIButton *_followButton;
	IBOutlet UILabel *_followers;
	IBOutlet UILabel *_following;
	IBOutlet UILabel *_checkIns;
	IBOutlet UILabel *_points;
}
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) UIImageView *userImageView;
@property (nonatomic, retain) UILabel *username;
@property (nonatomic, retain) UIButton *followButton;
@property (nonatomic, retain) UILabel *followers;
@property (nonatomic, retain) UILabel *following;
@property (nonatomic, retain) UILabel *checkIns;
@property (nonatomic, retain) UILabel *points;

- (IBAction)followButtonPressed:(id)sender;
- (IBAction)followersButtonPressed:(id)sender;
- (IBAction)followingButtonPressed:(id)sender;
- (IBAction)checkInsButtonPressed:(id)sender;


@end
