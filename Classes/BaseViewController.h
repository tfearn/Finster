//
//  BaseViewController.h
//  HedgeHog
//
//  Created by Todd Fearn on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "WaitView.h"

@interface BaseViewController : UIViewController {
    WaitView *_waitView;
}
@property (nonatomic, readonly) WaitView *waitView;

- (void)showWaitView:(NSString *)message;
- (void)dismissWaitView;

@end
