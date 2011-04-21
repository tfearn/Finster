//
//  WallViewCell.h
//  Finster
//
//  Created by Todd Fearn on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WallViewCell : UITableViewCell {
	IBOutlet UIImageView *_userImageView;
	IBOutlet UIImageView *_checkInImageView;
	IBOutlet UILabel *_username;
	IBOutlet UILabel *_ticker;
	IBOutlet UILabel *_title;
	IBOutlet UILabel *_timestamp;
}
@property (nonatomic, retain) UIImageView *userImageView;
@property (nonatomic, retain) UIImageView *checkInImageView;
@property (nonatomic, retain) UILabel *username;
@property (nonatomic, retain) UILabel *ticker;
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UILabel *timestamp;

@end
