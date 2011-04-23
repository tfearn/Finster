//
//  WallViewController.h
//  Finster
//
//  Created by Todd Fearn on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "BaseViewController.h"
#import "Utility.h"
#import "CheckIn.h"
#import "WallViewCell.h"
#import "GetWallRequest.h"

@interface WallViewController : BaseViewController <RequestDelegate> {
	IBOutlet UITableView *_tableView;
	GetWallRequest *_request;
	NSMutableArray *_checkIns;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) GetWallRequest *request;
@property (nonatomic, retain) NSMutableArray *checkIns;

@end
