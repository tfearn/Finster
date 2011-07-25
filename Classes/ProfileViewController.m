    //
//  ProfileViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"


@interface ProfileViewController (Private)
- (void)getData;
@end

@implementation ProfileViewController
@synthesize tableView = _tableView;
@synthesize request = _request;
@synthesize imageManager = _imageManager;
@synthesize users = _users;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.tableView setRowHeight:44.0];

	// Initialize the ImageManager to get user pictures
	_imageManager = [[ImageManager alloc] init];
	self.imageManager.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
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
	[_imageManager release];
	[_users release];
    [super dealloc];
}

- (void)getData {
	_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:kUrlGetUserFollowing]];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
}

#pragma mark -
#pragma mark RequestDelegate Methods

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *response = [request responseString];
	
	SBJSON *jsonParser = [[[SBJSON alloc] init] autorelease];
	
	// Parse the data
	NSError *error = nil;
	NSDictionary *dict = [jsonParser objectWithString:response error:&error];
	if(error != nil) {
		NSLog(@"Parser Error: %@", [error description]);
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		return;
	}
	
	[_users release];
	_users = [[NSMutableArray alloc] init];
	
	NSArray *following = [dict objectForKey:@"following"];
	for(int i=0; i<[following count]; i++) {
		NSDictionary *userParentDict = [following objectAtIndex:i];
		NSDictionary *userDict = [userParentDict objectForKey:@"user"];
		
		User *user = [[User alloc] init];
		user.userID = [[userDict objectForKey:@"id"] stringValue];
		user.groupType = [userDict objectForKey:@"group"];
		user.userName = [userDict objectForKey:@"name"];
		user.imageUrl = [userDict objectForKey:@"image"];
		user.followers = [[userDict objectForKey:@"followers"] intValue];
		user.following = [[userDict objectForKey:@"following"] intValue];
		user.checkins = [[userDict objectForKey:@"checkins"] intValue];
		user.badges = [[userDict objectForKey:@"badges"] intValue];
		
		[self.users addObject:user];
		[user release];
	}
	
	// Tell the ImageManager to get the pictures if it does not already have them
	for(int i=0; i<[self.users count]; i++) {
		id object = [self.users objectAtIndex:i];
		User *user = object;
		
		Image *image = [self.imageManager getImage:user.imageUrl];
		if(image != nil)
			user.image = image.image;
	}
	
	// Reload the table
	[self.tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	[self dismissWaitView];
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:[request.error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}


#pragma mark -
#pragma mark ImageManagerDelegate Methods

- (void)imageRequestComplete:(Image *)image {
	
	// Search through the User list to find the matching using image url
	for(int i=0; i<[self.users count]; i++) {
		id object = [self.users objectAtIndex:i];
		User *user = object;
		
		if([user.imageUrl isEqualToString:image.url]) {
			user.image = image.image;
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
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(section == 0)
		return 2;
	else
		return [self.users count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section == 0)
		return @"My Statistics";
	else
		return @"Following";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	int section = [indexPath section];
	int row = [indexPath row];
	
	if(section == 0) {
		switch (row) {
			case 0:
				cell.textLabel.text = @"Check-Ins";
				cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-clock" ofType:@"png"]];
				break;
			case 1:
				cell.textLabel.text = @"Points";
				cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-clock" ofType:@"png"]];
				break;
			default:
				break;
		}
	}
	else {
		User *user = [self.users objectAtIndex:row];
		
		cell.textLabel.text = user.userName;
		
		if(user.image == nil)
			cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"default-user" ofType:@"png"]];
		else
			cell.imageView.image = user.image;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	cell.textLabel.textColor = [UIColor darkGrayColor];
	cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int section = [indexPath section];
	int row = [indexPath row];
	
	if(section == 1) {
		User *user = [self.users objectAtIndex:row];
		UserViewController *controller = [[UserViewController alloc] init];
		controller.user = user;
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];	
	}
}

@end
