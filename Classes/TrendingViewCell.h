//
//  TrendingViewCell.h
//  Finster
//
//  Created by Todd Fearn on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TrendingViewCell : UITableViewCell {
	IBOutlet UILabel *_symbol;
	IBOutlet UILabel *_symbolName;
	IBOutlet UILabel *_checkins;
}
@property (nonatomic, retain) UILabel *symbol;
@property (nonatomic, retain) UILabel *symbolName;
@property (nonatomic, retain) UILabel *checkins;

@end
