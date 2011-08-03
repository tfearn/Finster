//
//  TrendingViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "BaseViewController.h"
#import "Trend.h"
#import "TrendingViewCell.h"

@interface TrendingViewController : BaseViewController <ASIHTTPRequestDelegate> {
	IBOutlet UITableView *_tableView;
	ASIHTTPRequest *_request;
	NSMutableArray *_trends;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) NSMutableArray *trends;

@end
