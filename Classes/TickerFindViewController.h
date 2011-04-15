//
//  TickerFindViewController.h
//  MoneyMouth
//
//  Created by Todd Fearn on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "JSON.h"
#import "Ticker.h"
#import "TickerFindViewCell.h"
#import "CheckInDetailViewController.h"

@interface TickerFindViewController : UIViewController <UIScrollViewDelegate, ASIHTTPRequestDelegate, SBJsonStreamParserAdapterDelegate> {
	IBOutlet UISearchBar *_searchBar;
	IBOutlet UITableView *_tableView;
	int _checkInType;
	NSMutableArray *_tickers;
	NSOperationQueue *_queue;
	SBJsonStreamParser *_jsonParser;
	SBJsonStreamParserAdapter *_jsonAdapter;
}
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView *tableView;
@property int checkInType;
@property (nonatomic, retain) NSMutableArray *tickers;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) SBJsonStreamParser *jsonParser;
@property (nonatomic, retain) SBJsonStreamParserAdapter *jsonAdapter;
@end
