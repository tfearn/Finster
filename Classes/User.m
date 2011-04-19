//
//  User.m
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "User.h"


@implementation User
@synthesize userID = _userID;
@synthesize userName = _userName;
@synthesize imageUrl = _imageUrl;

- (void)dealloc {
	[_userID release];
	[_userName release];
	[_imageUrl release];
	[super dealloc];
}

@end
