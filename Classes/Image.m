//
//  Image.m
//  Finster
//
//  Created by Todd Fearn on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Image.h"


@implementation Image
@synthesize url = _url;
@synthesize image = _image;
@synthesize requestOutstanding = _requestOutstanding;

- (void)dealloc {
	[_url release];
	[_image release];
	[super dealloc];
}

@end
