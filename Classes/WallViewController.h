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
#import "CheckIn.h"
#import "WallViewCell.h"
#import "GetWallRequest.h"
#import "ImageManager.h"
#import "CheckInDetailsViewController.h"
#import "TimePassedFormatter.h"
#import "CheckInTypeFormatter.h"

@interface WallViewController : BaseViewController <RequestDelegate, ImageManagerDelegate> {
	IBOutlet UITableView *_tableView;
	GetWallRequest *_request;
	NSMutableArray *_checkIns;
	ImageManager *_imageManager;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) GetWallRequest *request;
@property (nonatomic, retain) NSMutableArray *checkIns;
@property (nonatomic, retain) ImageManager *imageManager;

- (IBAction)refreshButtonPressed:(id)sender;

@end
