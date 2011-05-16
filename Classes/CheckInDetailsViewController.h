//
//  CheckInDetailsViewController.h
//  Finster
//
//  Created by Todd Fearn on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckIn.h"
#import "TimePassedFormatter.h"

@interface CheckInDetailsViewController : UIViewController {
	IBOutlet UIImageView *_userImageView;
	IBOutlet UILabel *_username;
	IBOutlet UIImageView *_checkInImageView;
	IBOutlet UILabel *_description;
	IBOutlet UILabel *_timestamp;
	IBOutlet UILabel *_symbolName;
	IBOutlet UILabel *_symbolType;
	IBOutlet UILabel *_exchangeName;
	IBOutlet UITextView *_comments;
	CheckIn *_checkIn;
}
@property (retain, nonatomic) UIImageView *userImageView;
@property (retain, nonatomic) UILabel *username;
@property (retain, nonatomic) UIImageView *checkInImageView;
@property (retain, nonatomic) UILabel *description;
@property (retain, nonatomic) UILabel *timestamp;
@property (retain, nonatomic) UILabel *symbolName;
@property (retain, nonatomic) UILabel *symbolType;
@property (retain, nonatomic) UILabel *exchangeName;
@property (retain, nonatomic) UITextView *comments;
@property (retain, nonatomic) CheckIn *checkIn;

@end
