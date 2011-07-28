//
//  CheckInsByUserViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCheckInsViewController.h"
#import "User.h"

@interface CheckInsByUserViewController : BaseCheckInsViewController {
	User *_user;
}
@property (nonatomic, retain) User *user;

@end
