    //
//  CheckInResultViewController.m
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInResultViewController.h"


@implementation CheckInResultViewController
@synthesize description = _description;
@synthesize tableView = _tableView;
@synthesize checkInType = _checkInType;
@synthesize ticker = _ticker;
@synthesize checkInResult = _checkInResult;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.navigationController setNavigationBarHidden:YES animated:NO]; 
	
	CheckInTypeFormatter *formatter = [[[CheckInTypeFormatter alloc] init] autorelease];
	NSString *checkInString = [formatter format:self.checkInType symbol:self.ticker.symbol];
	self.description.text = [NSString stringWithFormat:@"Ok!  We have you as '%@'", checkInString];
	
	// Send notification
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotificationCheckIn object:self];
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
	[_description release];
	[_tableView release];
	[_ticker release];
	[_checkInResult release];
    [super dealloc];
}

- (IBAction)closeButtonPressed:(id)sender {
	[self.navigationController setNavigationBarHidden:NO animated:NO]; 

	[self.navigationController popToRootViewControllerAnimated:YES];;
}

#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	int row = [indexPath row];
	if(row == 0) {
		cell.textLabel.text = [NSString stringWithFormat:@"You earned %d points for this check-in", self.checkInResult.pointsEarned];
		cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-clock" ofType:@"png"]];
	}
	else if(row == 1) {
		cell.textLabel.text = [NSString stringWithFormat:@"You now have %d total points", self.checkInResult.totalPoints];
		cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-clock" ofType:@"png"]];
	}
	else if(row == 2) {
		cell.textLabel.text = [NSString stringWithFormat:@"You have %d check-ins for %@", self.checkInResult.checkInsForTicker, self.ticker.symbol];
		cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-user" ofType:@"png"]];
	}
	else if(row == 3) {
		int total = self.checkInResult.otherTickerInterest;
		cell.textLabel.text = [NSString stringWithFormat:@"Others checked into %@ %d times", self.ticker.symbol, total];
		cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-group" ofType:@"png"]];
	}
	cell.textLabel.textColor = [UIColor darkGrayColor];
	cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
