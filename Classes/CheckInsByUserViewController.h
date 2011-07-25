//
//  CheckInsByUserViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCheckInsViewController.h"

@interface CheckInsByUserViewController : BaseCheckInsViewController {
	NSString *_userID;
}
@property (nonatomic, retain) NSString *userID;

@end
