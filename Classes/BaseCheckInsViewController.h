//
//  BaseCheckInsViewController.h
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

@interface BaseCheckInsViewController : PullRefreshTableViewController <ASIHTTPRequestDelegate, ImageManagerDelegate, UITableViewDataSource, UITableViewDelegate> {
	ASIHTTPRequest *_request;
	SBJSON *_jsonParser;
	NSMutableArray *_checkIns;
	ImageManager *_imageManager;
	
	int startRow;
}
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) SBJSON *jsonParser;
@property (nonatomic, retain) NSMutableArray *checkIns;
@property (nonatomic, retain) ImageManager *imageManager;

- (NSString *)getRequestUrl;

@end
