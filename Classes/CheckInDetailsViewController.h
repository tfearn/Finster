//
//  CheckInDetailsViewController.h
//  Finster
//
//  Created by Todd Fearn on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCheckInViewController.h"
#import "CheckIn.h"
#import "TimePassedFormatter.h"
#import "UserViewController.h"

@interface CheckInDetailsViewController : BaseCheckInViewController {
	IBOutlet UIImageView *_userImageView;
	IBOutlet UILabel *_username;
	IBOutlet UIImageView *_checkInImageView;
	IBOutlet UILabel *_timestamp;
	IBOutlet UITextView *_comments;
	CheckIn *_checkIn;
}
@property (retain, nonatomic) UIImageView *userImageView;
@property (retain, nonatomic) UILabel *username;
@property (retain, nonatomic) UIImageView *checkInImageView;
@property (retain, nonatomic) UILabel *timestamp;
@property (retain, nonatomic) UITextView *comments;
@property (retain, nonatomic) CheckIn *checkIn;

- (IBAction)usernamePressed:(id)sender;

@end
