//
//  LeaderboardViewCell.m
//  Finster
//
//  Created by Todd Fearn on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LeaderboardViewCell.h"


@implementation LeaderboardViewCell
@synthesize userImageView = _userImageView;
@synthesize username = _username;
@synthesize score = _score;

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
	[_username release];
	[_score release];
    [super dealloc];
}


@end
