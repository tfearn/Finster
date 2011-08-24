    //
//  LastCheckinsViewController.m
//  Finster
//
//  Created by Todd Fearn on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LastCheckinsViewController.h"


@interface LastCheckinsViewController (Private)
- (void)getData;
@end


@implementation LastCheckinsViewController
@synthesize userImageView = _userImageView;
@synthesize username = _username;
@synthesize tableView = _tableView;
@synthesize request = _request;
@synthesize jsonParser = _jsonParser;
@synthesize imageManager = _imageManager;
@synthesize checkIns = _checkIns;
@synthesize user = _user;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"Market Outlook";
	
	[self.tableView setRowHeight:70.0];
	
	// Initialize the JSON parser
	_jsonParser = [[SBJSON alloc] init];

	// Initialize the ImageManager to get user pictures
	_imageManager = [[ImageManager alloc] init];
	self.imageManager.delegate = self;
	
	// Set the username label
	self.username.text = self.user.userName;
	
	// Tell the ImageManager to get the pictures if it does not already have them
	if(self.user != nil) {
		Image *image = [self.imageManager getImage:self.user.imageUrl];
		if(image != nil) {
			self.user.image = image.image;
			[self.userImageView setImage:self.user.image];
		}
	}
	
	// Do a request for data
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
	if(self.request != nil)
		[_request clearDelegatesAndCancel];
	
	[_userImageView release];
	[_username release];
	[_tableView release];
	[_jsonParser release];
	[_imageManager release];
	[_checkIns release];
	[_user release];
    [super dealloc];
}

- (void)getData {
	NSString *url = kUrlGetUserLastCheckins;
	if(self.user != nil && self.user.userID != nil)
		url = [url stringByAppendingFormat:@"?userid=%@", self.user.userID];

	_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
}


#pragma mark -
#pragma mark RequestDelegate Methods

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *response = [request responseString];
	
	// Parse the data
	NSError *error = nil;
	NSDictionary *dict = [self.jsonParser objectWithString:response error:&error];
	if(error != nil) {
		[Globals logError:error name:@"JSON_Parser_Error" detail:response];
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		
		_request = nil;
		return;
	}
	
	[_checkIns release];
	_checkIns = [[NSMutableArray alloc] init];
	
	// Get the checkInList which is another dictionary
	NSArray *checkInList = [dict objectForKey:@"checkInList"];
	if(checkInList == nil)
		return;
	
	// Walk through the array and parse the dictionaries
	for(int i=0; i<[checkInList count]; i++) {
		NSDictionary *checkInDict = [checkInList objectAtIndex:i];
		
		CheckIn *checkIn = [[CheckIn alloc] init];
		[checkIn assignValuesFromDictionary:checkInDict];
		
		NSDictionary *user = [checkInDict objectForKey:@"user"];
		[checkIn.user assignValuesFromDictionary:user];
		
		NSDictionary *ticker = [checkInDict objectForKey:@"ticker"];
		[checkIn.ticker assignValuesFromDictionary:ticker];
		
		[self.checkIns addObject:checkIn];
		[checkIn release];
	}
	
	// Reload the table
	[self.tableView reloadData];
	
	// Release the request
	_request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	MyLog(@"Network Error: %@", [request.error description]);
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Cannot connect to the network" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
	
	_request = nil;
}


#pragma mark -
#pragma mark ImageManagerDelegate Methods

- (void)imageRequestComplete:(Image *)image {
	[self.userImageView setImage:image.image];
}

- (void)imageRequestFailure:(NSString *)url {
	// We don't care if it fails
}


#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableview {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section {
	return [self.checkIns count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Last check-in for ticker";
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CustomCellIdentifier = @"LastCheckInsViewCellIdentifier ";
	
	LastCheckinsViewCell *cell = (LastCheckinsViewCell *)[tableview dequeueReusableCellWithIdentifier: CustomCellIdentifier];
	if (cell == nil)  {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LastCheckinsViewCell" owner:self options:nil];
		for (id oneObject in nib)
			if ([oneObject isKindOfClass:[LastCheckinsViewCell class]])
				cell = (LastCheckinsViewCell *)oneObject;
	}
	
	int row = [indexPath row];
	CheckIn *checkIn = [self.checkIns objectAtIndex:row];
	
	cell.ticker.text = checkIn.ticker.symbol;
	cell.company.text = checkIn.ticker.symbolName;
	
	// Determine the differnce between the check-in time and the current time
	TimePassedFormatter *timePassedFormatter = [[[TimePassedFormatter alloc] init] autorelease];
	cell.timestamp.text = [timePassedFormatter format:checkIn.timestamp];
	
	switch (checkIn.checkinType) {
		case kCheckInTypeIBought:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dollars-icon" ofType:@"png"]];
			cell.arrowImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"up-arrow" ofType:@"png"]];
			break;
		case kCheckInTypeISold:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"check-icon" ofType:@"png"]];
			cell.arrowImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"down-arrow" ofType:@"png"]];
			break;
		case kCheckinTypeGoodRumour:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"thumbs-up-icon" ofType:@"png"]];
			cell.arrowImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"up-arrow" ofType:@"png"]];
			break;
		case kCheckinTypeBadRumour:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"thumbs-down-icon" ofType:@"png"]];
			cell.arrowImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"down-arrow" ofType:@"png"]];
			break;
		case kCheckInTypeImBullish:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bullish-icon" ofType:@"png"]];
			cell.arrowImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"up-arrow" ofType:@"png"]];
			break;
		case kCheckInTypeImBearish:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bearish-icon" ofType:@"png"]];
			cell.arrowImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"down-arrow" ofType:@"png"]];
			break;
		default:
			break;
	}
	
	return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int row = [indexPath row];
	CheckIn *checkIn = [self.checkIns objectAtIndex:row];
	
	checkIn.user.image = self.userImageView.image;
	
	CheckInDetailsViewController *controller = [[CheckInDetailsViewController alloc] init];
	controller.checkIn = checkIn;
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

@end
