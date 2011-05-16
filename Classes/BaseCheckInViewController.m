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
	CheckInTypeFormatter *formatter = [[[CheckInTypeFormatter alloc] init] autorelease];
	self.description.text = [formatter format:self.checkInType symbol:self.ticker.symbol];
	
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
