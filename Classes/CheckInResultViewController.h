//
//  CheckInResultViewController.h
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "BaseViewController.h"
#import "Ticker.h"
#import "CheckInTypeFormatter.h"
#import "CheckInRequest.h"

@interface CheckInResultViewController : BaseViewController {
	IBOutlet UILabel *_description;
	IBOutlet UITableView *_tableView;
	int _checkInType;
	Ticker *_ticker;
	CheckInRequest *_checkInRequest;
}
@property (nonatomic, retain) UILabel *description;
@property (nonatomic, retain) UITableView *tableView;
@property int checkInType;
@property (nonatomic, retain) Ticker *ticker;
@property (nonatomic, retain) CheckInRequest *checkInRequest;

- (IBAction)closeButtonPressed:(id)sender;

@end
