    //
//  BaseViewController.m
//  HedgeHog
//
//  Created by Todd Fearn on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"


@implementation BaseViewController
@synthesize waitView = _waitView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)showWaitView:(NSString *)message {
    _waitView = [[WaitView alloc] initWithMessage: message];
    [self.view addSubview: _waitView];
}

- (void)dismissWaitView {
	if (_waitView) {
		[_waitView removeFromSuperview];
		[_waitView release];
		_waitView = nil;
	}
}

- (void)dealloc {
    [super dealloc];
}

@end
