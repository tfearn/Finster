//
//  BaseCheckInsViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Globals.h"
#import "BaseViewController.h"
#import "CheckIn.h"
#import "BaseCheckInsViewCell.h"
#import "ImageManager.h"
#import "CheckInDetailsViewController.h"
#import "TimePassedFormatter.h"
#import "CheckInTypeFormatter.h"

@interface BaseCheckInsViewController : BaseViewController <ASIHTTPRequestDelegate, ImageManagerDelegate> {
	IBOutlet UITableView *_tableView;
	ASIHTTPRequest *_request;
	SBJSON *_jsonParser;
	NSMutableArray *_checkIns;
	ImageManager *_imageManager;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) SBJSON *jsonParser;
@property (nonatomic, retain) NSMutableArray *checkIns;
@property (nonatomic, retain) ImageManager *imageManager;

- (IBAction)refreshButtonPressed:(id)sender;
- (NSString *)getRequestUrl;

@end
