//
//  LastCheckinsViewController.h
//  Finster
//
//  Created by Todd Fearn on 8/22/11.
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
#import "LastCheckinsViewCell.h"

@interface LastCheckinsViewController : BaseViewController <ASIHTTPRequestDelegate> {
	IBOutlet UITableView *_tableView;
	ASIHTTPRequest *_request;
	SBJSON *_jsonParser;
	NSMutableArray *_checkIns;
	User *_user;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) SBJSON *jsonParser;
@property (nonatomic, retain) NSMutableArray *checkIns;
@property (nonatomic, retain) User *user;

@end
