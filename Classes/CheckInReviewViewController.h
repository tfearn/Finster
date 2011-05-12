//
//  CheckInReviewViewController.h
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCheckInViewController.h"
#import "CheckInConfirmViewController.h"
#import "DbSearchedTickerInsert.h"

@interface CheckInReviewViewController : BaseCheckInViewController {
	IBOutlet UITableView *_tableView;
}
@property (nonatomic, retain) UITableView *tableView;

- (IBAction)checkInButtonPressed:(id)sender;

@end
