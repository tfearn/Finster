//
//  BaseCheckInsViewCell.m
//  Finster
//
//  Created by Todd Fearn on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseCheckInsViewCell.h"

@implementation BaseCheckInsViewCell
@synthesize userImageView = _userImageView;
@synthesize checkInImageView = _checkInImageView;
@synthesize username = _username;
@synthesize ticker = _ticker;
@synthesize title = _title;
@synthesize company = _company;
@synthesize timestamp = _timestamp;

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
	[_userImageView release];
	[_checkInImageView release];
	[_username release];
	[_ticker release];
	[_title release];
	[_company release];
	[_timestamp release];
    [super dealloc];
}


@end
