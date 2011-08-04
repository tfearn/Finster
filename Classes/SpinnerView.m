//
//  SpinnerView.m
//  Finster
//
//  Created by Todd Fearn on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpinnerView.h"


@implementation SpinnerView

- (id)init {
    if (self = [super init]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		self.backgroundColor = [UIColor clearColor];
		
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[_spinner startAnimating];
		
		[self addSubview:_spinner];
    }
    return self;
}

- (void)layoutSubviews {
    CGRect screenBounds = self.superview.bounds;
    CGFloat width  = CGRectGetWidth(screenBounds);
    CGFloat height = CGRectGetHeight(screenBounds);
	
    CGRect viewFrame = CGRectMake(0.0, 0.0, width, height);
    self.frame = viewFrame;
    
    _spinner.center = CGPointMake(width/2, height/3);
}

- (void)dealloc {
	[_spinner release];
    [super dealloc];
}

@end
