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
	IBOutlet UILabel *_version;
}
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UILabel *version;

- (IBAction)iBoughtPressed:(id)sender;
- (IBAction)iSoldPressed:(id)sender;
- (IBAction)goodRumourPressed:(id)sender;
- (IBAction)badRumourPressed:(id)sender;
- (IBAction)imBullishPressed:(id)sender;
- (IBAction)imBearishPressed:(id)sender;

@end
