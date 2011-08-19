    //
//  LeaderboardViewController.m
//  Finster
//
//  Created by Todd Fearn on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LeaderboardViewController.h"


@implementation LeaderboardViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"Leaderboard";
	
	[self getUrl:kUrlGetLeaderboard];
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
    [super dealloc];
}

- (NSString *)getReturnedDataJSONRoot {
	return @"leaderboard";
}


#pragma mark -
#pragma mark UITableViewDataSource Methods

// Override this method for a custom cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
	
	LeaderboardViewCell *cell = (LeaderboardViewCell *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
	if (cell == nil)  {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LeaderboardViewCell" owner:self options:nil];
		for (id oneObject in nib)
			if ([oneObject isKindOfClass:[LeaderboardViewCell class]])
				cell = (LeaderboardViewCell *)oneObject;
	}
	
	int row = [indexPath row];
	User *user = [self.users objectAtIndex:row];
	
	cell.position.text = [NSString stringWithFormat:@"#%d", row+1];
	cell.username.text = user.userName;
	cell.score.text = [NSString stringWithFormat:@"%d", user.points];
	if(user.image != nil)
		cell.userImageView.image = user.image;
	else
		cell.userImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"default-user" ofType:@"png"]];
    
    return cell;
}

@end
