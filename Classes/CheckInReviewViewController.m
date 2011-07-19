    //
//  CheckInReviewViewController.m
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInReviewViewController.h"

@implementation CheckInReviewViewController
@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Insert the ticker into the database
	NSError *error = [DbSearchedTickerInsert doInsert:self.ticker];
	if(error != nil)
		MyLog(@"Local Database Error: %@", [error description]);
}

- (void)dealloc {
	[_tableView release];
    [super dealloc];
}

- (IBAction)checkInButtonPressed:(id)sender {
	
	CheckInConfirmViewController *controller = [[CheckInConfirmViewController alloc] init];
	controller.ticker = self.ticker;
	controller.checkInType = self.checkInType;
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

#pragma mark -
#pragma mark UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return nil;
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
		cell.textLabel.text = @"Recent Check Ins";
		cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-clock" ofType:@"png"]];
	}
	// TODO - add these features later
	else if(row == 1) {
		cell.textLabel.text = @"Gurus";
		cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-group" ofType:@"png"]];
	}
	else {
		cell.textLabel.text = @"Ticker Details";
		cell.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar-line-chart" ofType:@"png"]];
	}
	cell.textLabel.textColor = [UIColor darkGrayColor];
	cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int row = [indexPath row];
	if(row == 0) {
		CheckInsByTickerViewController *controller = [[CheckInsByTickerViewController alloc] init];
		[controller setSymbol:self.ticker.symbol];
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];
	}
}


@end
