    //
//  BaseCheckInViewController.m
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseCheckInViewController.h"


@implementation BaseCheckInViewController
@synthesize description = _description;
@synthesize symbolName = _symbolName;
@synthesize symbolType = _symbolType;
@synthesize exchangeName = _exchangeName;
@synthesize checkInType = _checkInType;
@synthesize ticker = _ticker;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"Check In";
	
	switch (self.checkInType) {
		case kCheckInTypeIBought:
			self.description.text = [NSString stringWithFormat:@"I Bought %@", self.ticker.symbol];
			break;
		case kCheckInTypeISold:
			self.description.text = [NSString stringWithFormat:@"I Sold %@", self.ticker.symbol];
			break;
		case kCheckinTypeShouldIBuy:
			self.description.text = [NSString stringWithFormat:@"Should I Buy %@?", self.ticker.symbol];
			break;
		case kCheckInTypeShouldISell:
			self.description.text = [NSString stringWithFormat:@"Should I Sell %@?", self.ticker.symbol];
			break;
		case kCheckInTypeImBullish:
			self.description.text = [NSString stringWithFormat:@"I'm Bullish on %@", self.ticker.symbol];
			break;
		case kCheckInTypeImBearish:
			self.description.text = [NSString stringWithFormat:@"I'm Bearish on %@", self.ticker.symbol];
			break;
		case kCheckInTypeImThinking:
			self.description.text = [NSString stringWithFormat:@"My Thoughts on %@", self.ticker.symbol];
			break;
		default:
			break;
	}
	
	self.symbolName.text = self.ticker.symbolName;
	self.symbolType.text = self.ticker.typeName;
	self.exchangeName.text = self.ticker.exchangeName;
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
	[_symbolName release];
	[_symbolType release];
	[_exchangeName release];
	[_ticker release];
    [super dealloc];
}

@end
