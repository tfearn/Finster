    //
//  WallViewController.m
//  Finster
//
//  Created by Todd Fearn on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WallViewController.h"

@interface WallViewController (Private)
- (void)getData;
@end


@implementation WallViewController
@synthesize tableView = _tableView;
@synthesize request = _request;
@synthesize checkIns = _checkIns;
@synthesize imageUrls = _imageUrls;
@synthesize queue = _queue;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.tableView setRowHeight:100.0];
	
	// Add the refresh button and the title button
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed:)];
	self.navigationItem.leftBarButtonItem = refreshButton; 
	[refreshButton release];
	
	// Do the initial request for data
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
	[_tableView release];
	[_request release];
	[_checkIns release];
	[_imageUrls release];
	[_queue release];
    [super dealloc];
}

- (IBAction)refreshButtonPressed:(id)sender {
	[self getData];
}

- (void)getData {
	_request = [[GetWallRequest alloc] init];
	self.request.delegate = self;
	[self.request get];
}

#pragma mark -
#pragma mark RequestDelegate Methods

-(void)requestComplete:(NSObject *)data {
	self.checkIns = (NSMutableArray *)data;
	
	// Initialize the network operation queue
	if (self.queue == nil) {
		_queue = [[NSOperationQueue alloc] init];
	}
	
	// Now start the image retrieval process
	for(CheckIn *checkIn in self.checkIns) {
		
		NSURL *imageUrl = checkIn.user.imageUrl;
		
		// Add the url to the request queue
		ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:imageUrl];
		[request setUserInfo:[NSDictionary dictionaryWithObject:imageUrl forKey:@"imageUrl"]];
		[request setDownloadCache:[ASIDownloadCache sharedCache]];
		[request setDelegate:self];
		[request setDidFinishSelector:@selector(imageRequestComplete:)];
		[request setDidFailSelector:@selector(imageRequestFailure:)];
		[self.queue addOperation:request];	
	}

	// Reload the table
	[self.tableView reloadData];
	
	// Release the request
	self.request = nil;
}

-(void)requestFailure:(NSString *)error {
	// TO DO: Just push the error to the console for now
	MyLog(@"GetWallRequest error: %@", error);
	
	// Release the request
	self.request = nil;
}

- (void)imageRequestComplete:(ASIHTTPRequest *)request {
	NSData *data = [request responseData];
	
	NSURL *url = [request.userInfo objectForKey:@"imageUrl"];
	
	// Search through the CheckIn list to find the matching using image url
	
}

- (void)imageRequestFailure:(ASIHTTPRequest *)request {
	// We don't care if it fails
}


#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.checkIns count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"WallViewCellIdentifier ";
    
    WallViewCell *cell = (WallViewCell *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    if (cell == nil)  {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WallViewCell" owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[WallViewCell class]])
                cell = (WallViewCell *)oneObject;
    }
	
	int row = [indexPath row];
	CheckIn *checkIn = [self.checkIns objectAtIndex:row];
	cell.username.text = checkIn.user.userName;
	cell.ticker.text = checkIn.ticker.symbol;
	NSString *title = [[[NSString alloc] init] autorelease];
	title = [Utility getCheckInString:title checkInType:checkIn.checkinType symbol:checkIn.ticker.symbol];
	cell.title.text = title;
	cell.company.text = checkIn.ticker.symbolName;

	// Determine the differnce between the check-in time and the current time
	NSCalendar *sysCalendar = [NSCalendar currentCalendar];
	NSDate *now = [[[NSDate alloc] init] autorelease];
		
    // Determine months, days, etc.
	unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
	NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:checkIn.timestamp  toDate:now  options:0];
	int months = [breakdownInfo month];
	int days = [breakdownInfo day];
	int hours = [breakdownInfo hour];
	int minutes = [breakdownInfo minute];
	
	if(months > 0) {
		if(months > 1)
			cell.timestamp.text = [NSString stringWithFormat:@"%d months ago", months];
		else
			cell.timestamp.text = [NSString stringWithFormat:@"%d month ago", months];
	}
	else if(days > 0) {
		if(days > 1)
			cell.timestamp.text = [NSString stringWithFormat:@"%d days ago", days];
		else
			cell.timestamp.text = [NSString stringWithFormat:@"%d day ago", days];
	}
	else if(hours > 0) {
		if(hours > 1)
			cell.timestamp.text = [NSString stringWithFormat:@"%d hours ago", hours];
		else
			cell.timestamp.text = [NSString stringWithFormat:@"%d hour ago", hours];
	}
	else if(minutes > 0) {
		if(minutes > 1)
			cell.timestamp.text = [NSString stringWithFormat:@"%d minutes ago", minutes];
		else
			cell.timestamp.text = [NSString stringWithFormat:@"%d minute ago", minutes];
	}
	else {
		cell.timestamp.text = @"just a moment ago";
	}
	
	
	switch (checkIn.checkinType) {
		case kCheckInTypeIBought:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dollars-icon" ofType:@"png"]];
			break;
		case kCheckInTypeISold:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"check-icon" ofType:@"png"]];
			break;
		case kCheckinTypeShouldIBuy:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"thumbs-up-icon" ofType:@"png"]];
			break;
		case kCheckInTypeShouldISell:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"thumbs-down-icon" ofType:@"png"]];
			break;
		case kCheckInTypeImBullish:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bullish-icon" ofType:@"png"]];
			break;
		case kCheckInTypeImBearish:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bearish-icon" ofType:@"png"]];
			break;
		case kCheckInTypeImThinking:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"thinking-icon" ofType:@"png"]];
			break;
		default:
			break;
	}
	
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//int row = [indexPath row];
}

@end
