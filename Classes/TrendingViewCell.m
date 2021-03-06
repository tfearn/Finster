//
//  TrendingViewCell.m
//  Finster
//
//  Created by Todd Fearn on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TrendingViewCell.h"


@implementation TrendingViewCell
@synthesize symbol = _symbol;
@synthesize symbolName = _symbolName;
@synthesize exchangeName = _exchangeName;
@synthesize checkins = _checkins;
@synthesize arrowImageView = _arrowImageView;

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
	[_checkins release];
	[_arrowImageView release];
    [super dealloc];
}


@end
