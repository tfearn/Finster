    //
//  BaseCheckInsViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseCheckInsViewController.h"


@interface BaseCheckInsViewController (Private)
- (void)getData;
@end


@implementation BaseCheckInsViewController
@synthesize tableView = _tableView;
@synthesize request = _request;
@synthesize checkIns = _checkIns;
@synthesize imageManager = _imageManager;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.tableView setRowHeight:100.0];
	
	// Add the refresh button and the title button
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed:)];
	self.navigationItem.leftBarButtonItem = refreshButton; 
	[refreshButton release];
	
	// Initialize the ImageManager to get user pictures
	_imageManager = [[ImageManager alloc] init];
	self.imageManager.delegate = self;
	
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
	[_tableView release];
	[_request release];
	[_checkIns release];
	[_imageManager release];
    [super dealloc];
}

- (IBAction)refreshButtonPressed:(id)sender {
	[self getData];
}

- (void)getData {
	[_request release];
	_request = [[GetCheckInRequest alloc] init];
	self.request.delegate = self;
	[self.request get:[self getRequestUrl]];
}

- (NSString *)getRequestUrl {
	return nil;
}

#pragma mark -
#pragma mark RequestDelegate Methods

-(void)requestComplete:(NSObject *)data {
	self.checkIns = (NSMutableArray *)data;
	
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
	self.request = nil;
}

-(void)requestFailure:(NSString *)error {
	// TO DO: Just push the error to the console for now
	MyLog(@"GetWallRequest error: %@", error);
	
	// Release the request
	self.request = nil;
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
	
	// Reload the table
	[self.tableView reloadData];
}

- (void)imageRequestFailure:(NSString *)url {
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
    static NSString *CustomCellIdentifier = @"BaseCheckInsViewCellIdentifier ";
    
    BaseCheckInsViewCell *cell = (BaseCheckInsViewCell *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    if (cell == nil)  {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BaseCheckInsViewCell" owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[BaseCheckInsViewCell class]])
                cell = (BaseCheckInsViewCell *)oneObject;
    }
	
	int row = [indexPath row];
	CheckIn *checkIn = [self.checkIns objectAtIndex:row];
	
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
	CheckIn *checkIn = [self.checkIns objectAtIndex:row];
	
	CheckInDetailsViewController *controller = [[CheckInDetailsViewController alloc] init];
	controller.checkIn = checkIn;
	[controller setHidesBottomBarWhenPushed:YES];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

@end
