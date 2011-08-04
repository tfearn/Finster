//
//  FollowingViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUserListViewController.h"
#import "User.h"

@interface FollowingViewController : BaseUserListViewController {
	User *_user;
}
@property (nonatomic, retain) User *user;

@end
