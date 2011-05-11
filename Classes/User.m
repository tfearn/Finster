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
@synthesize groupType = _groupType;
@synthesize userName = _userName;
@synthesize imageUrl = _imageUrl;
@synthesize image = _image;

- (void)dealloc {
	[_userID release];
	[_groupType release];
	[_userName release];
	[_imageUrl release];
	[_image release];
	[super dealloc];
}

@end
