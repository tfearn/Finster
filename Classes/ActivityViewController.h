//
//  ActivityViewController.h
//  MoneyMouth
//
//  Created by Todd Fearn on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ActivityViewController : UIViewController {
	IBOutlet UITableView *_tableView;
}
@property (nonatomic, retain) UITableView *tableView;

@end
