//
//  UserViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUserViewController.h"

@interface UserViewController : BaseUserViewController {
	IBOutlet UIButton *_followButton;
	ASIHTTPRequest *_isFollowingUserRequest;
}
@property (nonatomic, retain) UIButton *followButton;
@property (nonatomic, retain) ASIHTTPRequest *isFollowingUserRequest;

- (IBAction)followButtonPressed:(id)sender;

@end
