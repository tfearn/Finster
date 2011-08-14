    //
//  TrendingViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TrendingViewController.h"

@interface TrendingViewController (Private)
- (void)getData;
@end


@implementation TrendingViewController
@synthesize request = _request;
@synthesize trends = _trends;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView.rowHeight = 50.0;
	
	[self getData];
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
	[_trends release];
    [super dealloc];
}

// This is called when the user pulls down the table to refresh.
- (void)refresh {
	[self getData];
}

- (void)getData {
	_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kUrlGetTrending]];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
}


#pragma mark -
#pragma mark RequestDelegate Methods

- (void)requestFinished:(ASIHTTPRequest *)request {
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
	
	NSString *response = [request responseString];
	
	SBJSON *jsonParser = [[[SBJSON alloc] init] autorelease];
	
	// Parse the data
	NSError *error = nil;
	NSDictionary *dict = [jsonParser objectWithString:response error:&error];
	MyLog(@"%@", dict);
	if(error != nil) {
		[Globals logError:error name:@"JSON_Parser_Error" detail:response];
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		return;
	}
	
	[_trends release];
	_trends = [[NSMutableArray alloc] init];
	
	NSArray *trendingList = [dict objectForKey:@"trendingList"];
	for(int i=0; i<[trendingList count]; i++) {
		NSDictionary *trendParentDict = [trendingList objectAtIndex:i];
		NSDictionary *trendDict = [trendParentDict objectForKey:@"trend"];
		
		Trend *trend = [[Trend alloc] init];
		trend.checkins = [[trendDict objectForKey:@"checkins"] longValue];
		trend.positive = [[trendDict objectForKey:@"positive"] longValue];
		trend.negative = [[trendDict objectForKey:@"negative"] longValue];

		NSDictionary *tickerDict = [trendDict objectForKey:@"ticker"];
		trend.ticker = [[Ticker alloc] init];
		[trend.ticker assignValuesFromDictionary:tickerDict];
		
		[self.trends addObject:trend];
		[trend release];
	}
	
	// Reload the table
	[self.tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
	
	[Globals showNetworkError:request.error];
}


#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.trends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CustomCellIdentifier = @"TrendingViewCellIdentifier ";
	
	TrendingViewCell *cell = (TrendingViewCell *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
	if (cell == nil)  {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TrendingViewCell" owner:self options:nil];
		for (id oneObject in nib)
			if ([oneObject isKindOfClass:[TrendingViewCell class]])
				cell = (TrendingViewCell *)oneObject;
	}
	int row = [indexPath row];
	
	Trend *trend = [self.trends objectAtIndex:row];
	
	cell.symbol.text = trend.ticker.symbol;
	cell.symbolName.text = trend.ticker.symbolName;
	cell.checkins.text = [NSString stringWithFormat:@"%d", trend.checkins];
	
	if(trend.positive >= trend.negative)
		cell.arrowImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"up-arrow" ofType:@"png"]];
	else
		cell.arrowImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"down-arrow" ofType:@"png"]];
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int row = [indexPath row];
	Trend *trend = [self.trends objectAtIndex:row];

	CheckInsByTickerViewController *controller = [[CheckInsByTickerViewController alloc] init];
	[controller setSymbol:trend.ticker.symbol];
	[controller setHidesBottomBarWhenPushed:YES];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

@end
