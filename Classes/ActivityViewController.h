//
//  ActivityViewController.h
//  MoneyMouth
//
//  Created by Todd Fearn on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ActivityViewController : BaseViewController {
	IBOutlet UITableView *_tableView;
}
@property (nonatomic, retain) UITableView *tableView;

@end
