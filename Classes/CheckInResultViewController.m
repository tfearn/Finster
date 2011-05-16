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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.navigationController setNavigationBarHidden:YES animated:NO]; 
	
	CheckInTypeFormatter *formatter = [[[CheckInTypeFormatter alloc] init] autorelease];
	NSString *checkInString = [formatter format:self.checkInType symbol:self.ticker.symbol];
	self.description.text = [NSString stringWithFormat:@"Ok!  We have you as '%@'", checkInString];
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
    [super dealloc];
}

- (IBAction)closeButtonPressed:(id)sender {
	[self.navigationController setNavigationBarHidden:NO animated:NO]; 

	[self.navigationController popToRootViewControllerAnimated:YES];;
}


@end
