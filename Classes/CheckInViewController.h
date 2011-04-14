//
//  CheckInViewController.h
//  MoneyMouth
//
//  Created by Todd Fearn on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "TickerFindViewController.h"

@interface CheckInViewController : UIViewController {
	IBOutlet UIScrollView *_scrollView;
}
@property (nonatomic, retain) UIScrollView *scrollView;

- (IBAction)iBoughtAStockPressed:(id)sender;
- (IBAction)iSoldAStockPressed:(id)sender;

@end
