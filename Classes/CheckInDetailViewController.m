    //
//  CheckInDetailViewController.m
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInDetailViewController.h"

@implementation CheckInDetailViewController
@synthesize tableView = _tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//
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

@end
