    //
//  CheckInViewController.m
//  MoneyMouth
//
//  Created by Todd Fearn on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInViewController.h"

@interface CheckInViewController (Private)
- (void)loadTickerFindViewController:(int)checkInType;
@end


@implementation CheckInViewController
@synthesize scrollView = _scrollView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.scrollView.contentSize = CGSizeMake(320, 560);
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
	[_scrollView release];
    [super dealloc];
}

- (void)loadTickerFindViewController:(int)checkInType {
	TickerFindViewController *controller = [[TickerFindViewController alloc] init];
	[controller setCheckInType:checkInType];
	[controller setHidesBottomBarWhenPushed:YES];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

- (IBAction)iBoughtPressed:(id)sender {
	[self loadTickerFindViewController:kCheckInTypeIBought];
}

- (IBAction)iSoldPressed:(id)sender {
	[self loadTickerFindViewController:kCheckInTypeISold];
}

- (IBAction)goodRumourPressed:(id)sender {
	[self loadTickerFindViewController:kCheckinTypeGoodRumour];
}

- (IBAction)badRumourPressed:(id)sender {
	[self loadTickerFindViewController:kCheckinTypeBadRumour];
}

- (IBAction)imBullishPressed:(id)sender {
	[self loadTickerFindViewController:kCheckInTypeImBullish];
}

- (IBAction)imBearishPressed:(id)sender {
	[self loadTickerFindViewController:kCheckInTypeImBearish];
}

	 
@end
