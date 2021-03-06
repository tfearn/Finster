//
//  TickerFindViewController.h
//  MoneyMouth
//
//  Created by Todd Fearn on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "BaseViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "JSON.h"
#import "Ticker.h"
#import "TickerFindViewCell.h"
#import "CheckInReviewViewController.h"
#import "DbSearchedTickerGet.h"

@interface TickerFindViewController : BaseViewController <UIScrollViewDelegate, ASIHTTPRequestDelegate> {
	IBOutlet UISearchBar *_searchBar;
	IBOutlet UITableView *_tableView;
	int _checkInType;
	NSMutableArray *_tickers;
	NSOperationQueue *_queue;
	SBJSON *_jsonParser;
}
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView *tableView;
@property int checkInType;
@property (nonatomic, retain) NSMutableArray *tickers;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) SBJSON *jsonParser;
@end
