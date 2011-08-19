    //
//  ActivityViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController (Private)
- (void)getData;
@end


@implementation ActivityViewController
@synthesize request = _request;
@synthesize requestCheckInsNetwork = _requestCheckInsNetwork;
@synthesize jsonParser = _jsonParser;
@synthesize checkIns = _checkIns;
@synthesize checkInsNetwork = _checkInsNetwork;
@synthesize imageManager = _imageManager;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.tableView setRowHeight:100.0];
	
	// Initialize the ImageManager to get user pictures
	_imageManager = [[ImageManager alloc] init];
	self.imageManager.delegate = self;
	
	// Initialize the JSON parser
	_jsonParser = [[SBJSON alloc] init];
	
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
	if(self.requestCheckInsNetwork != nil)
		[_requestCheckInsNetwork clearDelegatesAndCancel];
	
	[_jsonParser release];
	[_checkIns release];
	[_checkInsNetwork release];
	[_imageManager release];
    [super dealloc];
}

- (void)getData {
	// Do the request for You and Friends
	_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kUrlGetCheckInsYouFriends]];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
	
	// Do the request for Network
	_requestCheckInsNetwork = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kUrlGetCheckInsNetwork]];
	[self.requestCheckInsNetwork setDelegate:self];
	[self.requestCheckInsNetwork setDidFinishSelector:@selector(getCheckInsNetworkRequestComplete:)];
	[self.requestCheckInsNetwork setDidFailSelector:@selector(getCheckInsNetworkRequestFailure:)];
	[self.requestCheckInsNetwork startAsynchronous];
}

- (void)refresh {
	// This is called when the user pulls down the table to refresh.
	[self getData];
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
	
	// Tell the ImageManager to get the pictures if it does not already have them
	for(int i=0; i<[self.checkIns count]; i++) {
		id object = [self.checkIns objectAtIndex:i];
		CheckIn *checkIn = object;
		
		Image *image = [self.imageManager getImage:checkIn.user.imageUrl];
		if(image != nil)
			checkIn.user.image = image.image;
	}
	
	// Reload the table
	[self.tableView reloadData];
	
	// Release the request
	_request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
	
	MyLog(@"Network Error: %@", [request.error description]);
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Cannot connect to the network" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
	
	_request = nil;
}

- (void)getCheckInsNetworkRequestComplete:(ASIHTTPRequest *)request {
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
	
	NSString *response = [request responseString];
	
	// Parse the data
	NSError *error = nil;
	NSDictionary *dict = [self.jsonParser objectWithString:response error:&error];
	if(error != nil) {
		[Globals logError:error name:@"JSON_Parser_Error" detail:response];
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		
		_requestCheckInsNetwork = nil;
		return;
	}
	
	[_checkInsNetwork release];
	_checkInsNetwork = [[NSMutableArray alloc] init];
	
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
		
		[self.checkInsNetwork addObject:checkIn];
		[checkIn release];
	}
	
	// Tell the ImageManager to get the pictures if it does not already have them
	for(int i=0; i<[self.checkInsNetwork count]; i++) {
		id object = [self.checkInsNetwork objectAtIndex:i];
		CheckIn *checkIn = object;
		
		Image *image = [self.imageManager getImage:checkIn.user.imageUrl];
		if(image != nil)
			checkIn.user.image = image.image;
	}
	
	// Reload the table
	[self.tableView reloadData];
	
	// Release the request
	_requestCheckInsNetwork = nil;
}

- (void)getCheckInsNetworkRequestFailure:(ASIHTTPRequest *)request {
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
	
	MyLog(@"Network Error: %@", [request.error description]);
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Cannot connect to the network" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
	
	_requestCheckInsNetwork = nil;
}


#pragma mark -
#pragma mark ImageManagerDelegate Methods

- (void)imageRequestComplete:(Image *)image {
	
	// Search through the CheckIn list to find the matching using image url
	for(int i=0; i<[self.checkIns count]; i++) {
		id object = [self.checkIns objectAtIndex:i];
		CheckIn *checkIn = object;
		
		if([checkIn.user.imageUrl isEqualToString:image.url]) {
			checkIn.user.image = image.image;
		}
	}
	
	// Search through the CheckInNetwork list to find the matching using image url
	for(int i=0; i<[self.checkInsNetwork count]; i++) {
		id object = [self.checkInsNetwork objectAtIndex:i];
		CheckIn *checkIn = object;
		
		if([checkIn.user.imageUrl isEqualToString:image.url]) {
			checkIn.user.image = image.image;
		}
	}

	// Reload the table
	[self.tableView reloadData];
}

- (void)imageRequestFailure:(NSString *)url {
	// We don't care if it fails
}


#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableview {
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section {
	if(section == 0)
		return [self.checkIns count];
	else
		return [self.checkInsNetwork count];
}

- (NSString *)tableView:(UITableView *)tableview titleForHeaderInSection:(NSInteger)section {
	if(section == 0)
		return @"You & People You Follow";
	else
		return @"Everyone";
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CustomCellIdentifier = @"BaseCheckInsViewCellIdentifier ";
	
	BaseCheckInsViewCell *cell = (BaseCheckInsViewCell *)[tableview dequeueReusableCellWithIdentifier: CustomCellIdentifier];
	if (cell == nil)  {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BaseCheckInsViewCell" owner:self options:nil];
		for (id oneObject in nib)
			if ([oneObject isKindOfClass:[BaseCheckInsViewCell class]])
				cell = (BaseCheckInsViewCell *)oneObject;
	}
	
	int row = [indexPath row];
	int section = [indexPath section];
	CheckIn *checkIn = nil;
	if(section == 0)
		checkIn = [self.checkIns objectAtIndex:row];
	else
		checkIn = [self.checkInsNetwork objectAtIndex:row];
	
	
	if(checkIn.user.image != nil)
		cell.userImageView.image = checkIn.user.image;
	
	cell.username.text = checkIn.user.userName;
	
	cell.ticker.text = checkIn.ticker.symbol;
	
	CheckInTypeFormatter *formatter = [[[CheckInTypeFormatter alloc] init] autorelease];
	cell.title.text = [formatter format:checkIn.checkinType symbol:checkIn.ticker.symbol];
	
	cell.company.text = checkIn.ticker.symbolName;
	
	// Determine the differnce between the check-in time and the current time
	TimePassedFormatter *timePassedFormatter = [[[TimePassedFormatter alloc] init] autorelease];
	cell.timestamp.text = [timePassedFormatter format:checkIn.timestamp];
	
	switch (checkIn.checkinType) {
		case kCheckInTypeIBought:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dollars-icon" ofType:@"png"]];
			break;
		case kCheckInTypeISold:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"check-icon" ofType:@"png"]];
			break;
		case kCheckinTypeGoodRumour:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"thumbs-up-icon" ofType:@"png"]];
			break;
		case kCheckinTypeBadRumour:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"thumbs-down-icon" ofType:@"png"]];
			break;
		case kCheckInTypeImBullish:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bullish-icon" ofType:@"png"]];
			break;
		case kCheckInTypeImBearish:
			cell.checkInImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bearish-icon" ofType:@"png"]];
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
	int section = [indexPath section];
	CheckIn *checkIn = nil;
	if(section == 0)
		checkIn = [self.checkIns objectAtIndex:row];
	else
		checkIn = [self.checkInsNetwork objectAtIndex:row];
	
	CheckInDetailsViewController *controller = [[CheckInDetailsViewController alloc] init];
	controller.checkIn = checkIn;
	[controller setHidesBottomBarWhenPushed:YES];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

@end