//
//  CheckInsByTickerViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCheckInsViewController.h"

@interface CheckInsByTickerViewController : BaseCheckInsViewController {
	NSString *_symbol;
}
@property (nonatomic, retain) NSString *symbol;

@end
