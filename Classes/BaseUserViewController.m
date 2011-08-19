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
@synthesize userImageView = _userImageView;
@synthesize username = _username;
@synthesize request = _request;
@synthesize imageManager = _imageManager;
@synthesize user = _user;
@synthesize leaderboard = _leaderboard;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[self.tableView setRowHeight:44.0];
	
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
	
	// Retrieve the user data
	[self getData];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
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
		[self.request clearDelegatesAndCancel];

	[_userImageView release];
	[_username release];
	[_imageManager release];
	[_user release];
	[_leaderboard release];
    [super dealloc];
}

- (void)getData {
	NSString *url = kUrlGetUser;
	if(self.user != nil && self.user.userID != nil)
		url = [url stringByAppendingFormat:@"?userid=%@", self.user.userID];
	
	_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	[self.request setDelegate:self];
	[self.request setDidFinishSelector:@selector(getUserRequestComplete:)];
	[self.request setDidFailSelector:@selector(getUserRequestFailure:)];
	[self.request startAsynchronous];
}

- (void)refresh {
	// This is called when the user pulls down the table to refresh.
	[self getData];
}

#pragma mark -
#pragma mark RequestDelegate Methods

- (void)getUserRequestComplete:(ASIHTTPRequest *)request {
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
	
	[_user release];
	_user = [[User alloc] init];
	[self.user assignValuesFromDictionary:dict];
	
	
	[_leaderboard release];
	_leaderboard = [[NSMutableArray alloc] init];
	
	NSArray *userList = [dict objectForKey:@"leaderboard"];
	for(int i=0; i<[userList count]; i++) {
		NSDictionary *userParentDict = [userList objectAtIndex:i];
		NSDictionary *userDict = [userParentDict objectForKey:@"user"];
		
		User *user = [[User alloc] init];
		[user assignValuesFromDictionary:userDict];
		
		[self.leaderboard addObject:user];
		[user release];
	}
	
	// Tell the ImageManager to get the pictures if it does not already have them
	for(int i=0; i<[self.leaderboard count]; i++) {
		id object = [self.leaderboard objectAtIndex:i];
		User *user = object;
		
		Image *image = [self.imageManager getImage:user.imageUrl];
		if(image != nil)
			user.image = image.image;
	}
	
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
	
	_request = nil;
}

- (void)getUserRequestFailure:(ASIHTTPRequest *)request {
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
	[Globals showNetworkError:request.error];
	
	_request = nil;
}


#pragma mark -
#pragma mark ImageManagerDelegate Methods

- (void)imageRequestComplete:(Image *)image {
	[self.userImageView setImage:image.image];
	
	[self.tableView reloadData];
}

- (void)imageRequestFailure:(NSString *)url {
	// We don't care if it fails
}


#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	// Show the leaderboard if we are viewing our own profile
	if(self.leaderboard != nil)
		return 2;
	else
		return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section == 0)
		return 4;
	else
		return [self.leaderboard count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section == 0)
		return @"My Statistics";
	else
		return @"Leaderboard";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
	
	UserViewCell *cell = (UserViewCell *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	if (cell == nil)  {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserViewCell" owner:self options:nil];
		for (id oneObject in nib)
			if ([oneObject isKindOfClass:[UserViewCell class]])
				cell = (UserViewCell *)oneObject;
	}
	cell.accessoryType = UITableViewCellAccessoryNone;
    
	int section = [indexPath section];
	int row = [indexPath row];
	
	if(section == 0) {
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
	}
	else {
		User *user = [self.leaderboard objectAtIndex:row];
		cell.position.text = [NSString stringWithFormat:@"#%d", row+1];
		cell.username.text = user.userName;
		cell.score.text = [NSString stringWithFormat:@"%d", user.points];
		if(user.image != nil)
			cell.userImageView.image = user.image;
		else
			cell.userImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"default-user" ofType:@"png"]];
	}
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int section = [indexPath section];
	int row = [indexPath row];
	
	if(section == 0) {
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
}

@end
