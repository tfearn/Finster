//
//  TickerFindViewCell.h
//  Money Mouth
//
//  Created by Todd Fearn on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TickerFindViewCell : UITableViewCell {
	IBOutlet UILabel *_symbol;
	IBOutlet UILabel *_symbolName;
	IBOutlet UILabel *_exchangeName;
}
@property (nonatomic, retain) UILabel *symbol;
@property (nonatomic, retain) UILabel *symbolName;
@property (nonatomic, retain) UILabel *exchangeName;

@end
