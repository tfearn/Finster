    //
//  LeaderboardViewController.m
//  Finster
//
//  Created by Todd Fearn on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LeaderboardViewController.h"


@implementation LeaderboardViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    [super dealloc];
}

#if 0
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
#endif

@end
