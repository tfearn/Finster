//
//  UserViewController.h
//  Finster
//
//  Created by Todd Fearn on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "User.h"

@interface UserViewController : BaseViewController {
	User *_user;
	IBOutlet UIImageView *_userImageView;
	IBOutlet UILabel *_username;
	IBOutlet UIButton *_followButton;
	IBOutlet UILabel *_followers;
	IBOutlet UILabel *_following;
}
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) UIImageView *userImageView;
@property (nonatomic, retain) UILabel *username;
@property (nonatomic, retain) UIButton *followButton;
@property (nonatomic, retain) UILabel *followers;
@property (nonatomic, retain) UILabel *following;

@end
