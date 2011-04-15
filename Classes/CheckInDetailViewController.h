//
//  CheckInDetailViewController.h
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticker.h"


@interface CheckInDetailViewController : UIViewController {
	IBOutlet UILabel *_description;
	IBOutlet UILabel *_symbolName;
	IBOutlet UILabel *_exchangeName;
	IBOutlet UITableView *_tableView;
	int _checkInType;
	Ticker *_ticker;
}
@property (nonatomic, retain) UILabel *description;
@property (nonatomic, retain) UILabel *symbolName;
@property (nonatomic, retain) UILabel *exchangeName;
@property (nonatomic, retain) UITableView *tableView;
@property int checkInType;
@property (nonatomic, retain) Ticker *ticker;

@end
