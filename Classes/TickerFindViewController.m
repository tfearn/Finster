    //
//  TickerFindViewController.m
//  MoneyMouth
//
//  Created by Todd Fearn on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TickerFindViewController.h"


@implementation TickerFindViewController
@synthesize searchBar = _searchBar;
@synthesize tableView = _tableView;
@synthesize checkInType = _checkInType;
@synthesize tickers = _tickers;
@synthesize queue = _queue;
@synthesize jsonParser = _jsonParser;
@synthesize jsonAdapter = _jsonAdapter;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	self.navigationItem.title = @"Symbol Lookup";
	
	// Set the table row height
	self.tableView.rowHeight = 50;
	
	// Setup the JSON Adapter & Parser
	_jsonAdapter = [SBJsonStreamParserAdapter new];
	self.jsonAdapter.delegate = self;
	
	_jsonParser = [SBJsonStreamParser new];
	self.jsonParser.delegate = self.jsonAdapter;
	self.jsonParser.multi = YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[_searchBar release];
	[_tableView release];
	[_queue release];
	[_jsonParser release];
	[_jsonAdapter release];
    [super dealloc];
}

- (void)doTickerRequest:(NSString *)searchText {
	if([searchText length] == 0)
		return;
	
	// Initialize the operation queue
	if (self.queue == nil) {
		_queue = [[NSOperationQueue alloc] init];
	}

	// Do the request
	NSString *urlString = [NSString stringWithFormat:kUrlTickerLookup, searchText];
	NSURL *url = [NSURL URLWithString:urlString];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[self.queue addOperation:request];
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate Methods

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *response = [request responseString];
	
	// Strip the YAHOO.Finance method function string
	response = [response stringByReplacingOccurrencesOfString:@"YAHOO.Finance.SymbolSuggest.ssCallback(" withString:@""];
	response = [response substringToIndex:[response length] - 1];
	
	// Setup the ticker array
	[_tickers release];
	_tickers = [[NSMutableArray alloc] init];

	// Parse the data
	SBJsonStreamParserStatus status = [self.jsonParser parse:[response dataUsingEncoding:NSUTF8StringEncoding]];
	if (status == SBJsonStreamParserError) {
		NSLog(@"Parser Error: %@", self.jsonParser.error);
	}
	
	// Refresh the table and move to top
	[self.tableView reloadData];
	[self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSError *error = [request error];
	
	// TO DO: Just log the error for now
	NSLog(@"%@", [error description]);
}

#pragma mark -
#pragma mark SBJsonStreamParserAdapterDelegate Methods

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
	NSLog(@"TickerFindViewController parsing error, we are not expecting arrays");	
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
	// Get the ResultSet which is another dictionary
	NSDictionary *resultSetDict = [dict objectForKey:@"ResultSet"];
	if(resultSetDict == nil)
		return;
	
	// Get the Result, which is an array
	NSArray *result = [resultSetDict objectForKey:@"Result"];
	if(result == nil)
		return;
	
	// Walk through the array and parse the dictionaries
	for(int i=0; i<[result count]; i++) {
		NSDictionary *tickerDict = [result objectAtIndex:i];
		
		Ticker *ticker = [[Ticker alloc] init];
		ticker.symbol = [tickerDict objectForKey:@"symbol"];
		ticker.symbolName = [tickerDict objectForKey:@"name"];
		ticker.type = [tickerDict objectForKey:@"type"];
		ticker.typeName = [tickerDict objectForKey:@"typeDisp"];
		ticker.exchange = [tickerDict objectForKey:@"exch"];
		ticker.exchangeName = [tickerDict objectForKey:@"exchDisp"];
		
		[self.tickers addObject:ticker];
		[ticker release];
	}
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	[self.searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.tickers count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"TickerFindViewCellIdentifier ";
    
    TickerFindViewCell *cell = (TickerFindViewCell *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    if (cell == nil)  {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TickerFindViewCell" owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[TickerFindViewCell class]])
                cell = (TickerFindViewCell *)oneObject;
    }
	
	int row = [indexPath row];
	Ticker *ticker = [self.tickers objectAtIndex:row];
	
	cell.symbolName.text = ticker.symbolName;
	cell.symbol.text = ticker.symbol;
	cell.exchangeName.text = ticker.exchangeName;
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int row = [indexPath row];
	Ticker *ticker = [self.tickers objectAtIndex:row];

	CheckInDetailViewController *controller = [[CheckInDetailViewController alloc] init];
	controller.ticker = ticker;
	controller.checkInType = self.checkInType;
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

#pragma mark -
#pragma mark UISearchBarDelegate Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	[self doTickerRequest:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
}

@end
