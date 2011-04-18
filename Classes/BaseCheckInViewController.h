//
//  BaseCheckInViewController.h
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "Ticker.h"

@interface BaseCheckInViewController : UIViewController {
	IBOutlet UILabel *_description;
	IBOutlet UILabel *_symbolName;
	IBOutlet UILabel *_symbolType;
	IBOutlet UILabel *_exchangeName;
	int _checkInType;
	Ticker *_ticker;
}
@property (nonatomic, retain) UILabel *description;
@property (nonatomic, retain) UILabel *symbolName;
@property (nonatomic, retain) UILabel *symbolType;
@property (nonatomic, retain) UILabel *exchangeName;
@property int checkInType;
@property (nonatomic, retain) Ticker *ticker;

@end
