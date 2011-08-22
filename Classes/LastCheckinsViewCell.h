//
//  LastCheckinsViewCell.h
//  Finster
//
//  Created by Todd Fearn on 8/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LastCheckinsViewCell : UITableViewCell {
	IBOutlet UILabel *_ticker;
	IBOutlet UILabel *_company;
	IBOutlet UILabel *_timestamp;
	IBOutlet UIImageView *_checkInImageView;
	IBOutlet UIImageView *_arrowImageView;
}
@property (nonatomic, retain) UILabel *ticker;
@property (nonatomic, retain) UILabel *company;
@property (nonatomic, retain) UILabel *timestamp;
@property (nonatomic, retain) UIImageView *checkInImageView;
@property (nonatomic, retain) UIImageView *arrowImageView;

@end
