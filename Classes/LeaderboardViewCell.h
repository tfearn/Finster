//
//  LeaderboardViewCell.h
//  Finster
//
//  Created by Todd Fearn on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LeaderboardViewCell : UITableViewCell {
	IBOutlet UILabel *_position;
	IBOutlet UIImageView *_userImageView;
	IBOutlet UILabel *_username;
	IBOutlet UILabel *_score;
}
@property (nonatomic, retain) UILabel *position;
@property (nonatomic, retain) UIImageView *userImageView;
@property (nonatomic, retain) UILabel *username;
@property (nonatomic, retain) UILabel *score;

@end
