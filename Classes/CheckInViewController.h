//
//  CheckInViewController.h
//  MoneyMouth
//
//  Created by Todd Fearn on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "BaseViewController.h"
#import "TickerFindViewController.h"

@interface CheckInViewController : BaseViewController {
	IBOutlet UIScrollView *_scrollView;
}
@property (nonatomic, retain) UIScrollView *scrollView;

- (IBAction)iBoughtPressed:(id)sender;
- (IBAction)iSoldPressed:(id)sender;
- (IBAction)shouldIBuyPressed:(id)sender;
- (IBAction)shouldISellPressed:(id)sender;
- (IBAction)imBullishPressed:(id)sender;
- (IBAction)imBearishPressed:(id)sender;
- (IBAction)imThinkingPressed:(id)sender;

@end
