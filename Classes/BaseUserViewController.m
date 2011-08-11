    //
//  BaseUserViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserViewController.h"

// Avoid circular references
#import "CheckInsByUserViewController.h"
#import "FollowingViewController.h"
#import "FollowersViewController.h"


@interface BaseUserViewController (Private)
- (void)getData;
@end

@implementation BaseUserViewController
@synthesize tableView = _tableView;
@synthesize userImageView = _userImageView;
@synthesize username = _username;
@synthesize queue = _queue;
@synthesize imageManager = _imageManager;
@synthesize user = _user;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.tableView setRowHeight:44.0];
	
	// Initialize the network queue
	_queue = [[NSOperationQueue alloc] init];

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
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	// Retrieve the data
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
	// Release all of the outstanding ASIHttpRequests
	NSArray *requests = [self.queue operations];
	for(int i=0; i<[requests count]; i++) {
		ASIHTTPRequest *request = [requests objectAtIndex:i];
		[request clearDelegatesAndCancel];
	}
	
	[_tableView release];
	[_userImageView release];
	[_username release];
	[_queue release];
	[_imageManager release];
	[_user release];
    [super dealloc];
}

- (void)getData {
	NSString *url = kUrlGetUser;
	if(self.user != nil && self.user.userID != nil)
		url = [url stringByAppendingFormat:@"?userid=%@", self.user.userID];
	
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(getUserRequestComplete:)];
	[request setDidFailSelector:@selector(getUserRequestFailure:)];
	[self.queue addOperation:request];
	
	[self showSpinnerView];
}


#pragma mark -
#pragma mark RequestDelegate Methods

- (void)getUserRequestComplete:(ASIHTTPRequest *)request {
	[self dismissSpinnerView];
	
	NSString *response = [request responseString];
	
	SBJSON *jsonParser = [[[SBJSON alloc] init] autorelease];
	
	// Parse the data
	NSError *error = nil;
	NSDictionary *dict = [jsonParser objectWithString:response error:&error];
	if(error != nil) {
		MyLog(@"Parser Error: %@", [error description]);
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		return;
	}
	
	[_user release];
	_user = [[User alloc] init];
	[self.user assignValuesFromDictionary:dict];
	
	// Set the username label
	self.username.text = self.user.userName;
	
	// If we don't have the image already, get it
	Image *image = [self.imageManager getImage:self.user.imageUrl];
	if(image != nil) {
		self.user.image = image.image;
		[self.userImageView setImage:self.user.image];
	}

	// Reload the table
	[self.tableView reloadData];
}

- (void)getUserRequestFailure:(ASIHTTPRequest *)request {
	[self dismissSpinnerView];
	[Globals showNetworkError:request.error];
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

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"My Statistics";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	int row = [indexPath row];
	switch (row) {
		case 0:
			cell.textLabel.text = [NSString stringWithFormat:@"%d Check-Ins", self.user.checkins];
			cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-clock" ofType:@"png"]];
			if(self.user.checkins > 0)
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 1:
			cell.textLabel.text = [NSString stringWithFormat:@"%d Points", self.user.points];
			cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-piggy-bank" ofType:@"png"]];
			break;
		case 2:
			cell.textLabel.text = [NSString stringWithFormat:@"Following %d", self.user.following];
			cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-group" ofType:@"png"]];
			if(self.user.following > 0)
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 3:
			cell.textLabel.text = [NSString stringWithFormat:@"Followers %d", self.user.followers];
			cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-group" ofType:@"png"]];
			if(self.user.followers > 0)
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		default:
			break;
	}
	
	cell.textLabel.textColor = [UIColor darkGrayColor];
	cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int row = [indexPath row];
	
	if(row == 0 & self.user.checkins > 0) {
		CheckInsByUserViewController *controller = [[CheckInsByUserViewController alloc] init];
		controller.user = self.user;
		[controller setHidesBottomBarWhenPushed:YES];
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];	
	}
	else if(row == 2 && self.user.following > 0) {
		FollowingViewController *controller = [[FollowingViewController alloc] init];
		controller.user = self.user;
		[controller setHidesBottomBarWhenPushed:YES];
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];	
	}
	else if(row == 3 && self.user.followers > 0) {
		FollowersViewController *controller = [[FollowersViewController alloc] init];
		controller.user = self.user;
		[controller setHidesBottomBarWhenPushed:YES];
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];	
	}
}

@end
