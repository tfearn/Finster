    //
//  CheckInsByTickerViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInsByTickerViewController.h"


@implementation CheckInsByTickerViewController
@synthesize symbol = _symbol;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *title = [NSString stringWithFormat:@"CheckIns for %@", self.symbol];
	
	[self.navigationItem setTitle:title];
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
	[_symbol release];
    [super dealloc];
}

- (NSString *)getRequestUrl {
	NSString *url = [NSString stringWithFormat:kUrlGetCheckInsByTicker, self.symbol];
	
	return url;
}

@end
