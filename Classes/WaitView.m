//
//  WaitView.m
//  HedgeHog
//
//  Created by Todd Fearn on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WaitView.h"


@implementation WaitView
@synthesize lockedOrientation = _lockedOrientation;

- (id)initWithMessage:(NSString *)message {
    if (self = [self init]) {
        self.waitText = message;
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		self.backgroundColor = [UIColor blackColor];
		self.alpha = 0.9;
		
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[_spinner startAnimating];
		
        _messageLabel = [[UILabel alloc] init];
		_messageLabel.textAlignment = UITextAlignmentCenter;
		_messageLabel.text = @"Please wait...";
		_messageLabel.opaque = NO;
		_messageLabel.backgroundColor = [UIColor clearColor];
		_messageLabel.textColor = [UIColor whiteColor];
		
		[self addSubview:_spinner];
		[self addSubview:_messageLabel];	
    }
    return self;
}

- (NSString *)waitText {
	return _messageLabel.text;
}

- (void)setWaitText:(NSString *)text {
	_messageLabel.text = text;
}

- (void)layoutSubviews {
    CGRect screenBounds = self.superview.bounds;
    CGFloat width  = CGRectGetWidth(screenBounds);
    CGFloat height = CGRectGetHeight(screenBounds);

    CGRect waitViewFrame = CGRectMake(0.0, 0.0, width, height);
    self.frame = waitViewFrame;
    _messageLabel.frame = CGRectMake(0, (height/3)-60, width, 30);
    
    _spinner.center = CGPointMake(width/2, height/3);
}

- (void)dealloc {
	[_spinner release];
	[_messageLabel release];
    [super dealloc];
}

@end
