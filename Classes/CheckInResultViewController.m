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
	
	switch (self.checkInType) {
		case kCheckInTypeBought:
			self.description.text = [NSString stringWithFormat:@"Ok! You Bought %@", self.ticker.symbol];
			break;
		case kCheckInTypeSold:
			self.description.text = [NSString stringWithFormat:@"Ok! You Sold %@", self.ticker.symbol];
			break;
		case kCheckinTypeShouldIBuy:
			self.description.text = [NSString stringWithFormat:@"Ok! Your status is 'Should I Buy %@?'", self.ticker.symbol];
			break;
		case kCheckInTypeShouldISell:
			self.description.text = [NSString stringWithFormat:@"Ok! Your status is 'Should I Sell %@?'", self.ticker.symbol];
			break;
		case kCheckInTypeImBullish:
			self.description.text = [NSString stringWithFormat:@"Ok! Your status is 'I am Bullish on %@'", self.ticker.symbol];
			break;
		case kCheckInTypeImBearish:
			self.description.text = [NSString stringWithFormat:@"Ok! Your status is 'I am Bearish on %@'", self.ticker.symbol];
			break;
		case kCheckInTypeImThinking:
			self.description.text = [NSString stringWithFormat:@"Ok! We submitted your 'Thoughts on %@'", self.ticker.symbol];
			break;
		default:
			break;
	}
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
