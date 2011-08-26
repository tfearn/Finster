//
//  ActivityViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "Globals.h"
#import "CheckIn.h"
#import "TimePassedFormatter.h"
#import "CheckInTypeFormatter.h"
#import "ImageManager.h"
#import "BaseViewController.h"
#import "BaseCheckInsViewCell.h"
#import "CheckInDetailsViewController.h"
#import "PullRefreshTableViewController.h"

@interface ActivityViewController : PullRefreshTableViewController <ASIHTTPRequestDelegate, ImageManagerDelegate, UITableViewDataSource, UITableViewDelegate> {
	ASIHTTPRequest *_request;
	ASIHTTPRequest *_requestCheckInsNetwork;
	SBJSON *_jsonParser;
	NSMutableArray *_checkIns;
	NSMutableArray *_checkInsNetwork;
	ImageManager *_imageManager;
	NSDate *_lastRequestDate;
}
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) ASIHTTPRequest *requestCheckInsNetwork;
@property (nonatomic, retain) SBJSON *jsonParser;
@property (nonatomic, retain) NSMutableArray *checkIns;
@property (nonatomic, retain) NSMutableArray *checkInsNetwork;
@property (nonatomic, retain) ImageManager *imageManager;
@property (nonatomic, retain) NSDate *lastRequestDate;


@end
