//
//  WaitView.h
//  HedgeHog
//
//  Created by Todd Fearn on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WaitView : UIView {
	UIActivityIndicatorView *_spinner;
    UILabel *_messageLabel;
    UIInterfaceOrientation _lockedOrientation;
    UIViewController *_parentViewController;
}
@property (nonatomic, retain) NSString *waitText;
@property (nonatomic, assign) UIInterfaceOrientation lockedOrientation;

- (id)initWithMessage:(NSString *)message;

@end
