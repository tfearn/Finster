//
//  LastCheckinsViewCell.m
//  Finster
//
//  Created by Todd Fearn on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LastCheckinsViewCell.h"


@implementation LastCheckinsViewCell
@synthesize ticker = _ticker;
@synthesize company = _company;
@synthesize timestamp = _timestamp;
@synthesize checkInImageView = _checkInImageView;
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
	[_ticker release];
	[_company release];
	[_timestamp release];
	[_checkInImageView release];
	[_arrowImageView release];
    [super dealloc];
}


@end
