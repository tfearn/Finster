//
//  TickerFindViewCell.m
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TickerFindViewCell.h"


@implementation TickerFindViewCell
@synthesize symbol = _symbol;
@synthesize symbolName = _symbolName;
@synthesize exchangeName = _exchangeName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[_symbol release];
	[_symbolName release];
	[_exchangeName release];
    [super dealloc];
}


@end
