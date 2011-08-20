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
@synthesize followers = _followers;
@synthesize following = _following;
@synthesize checkins = _checkins;
@synthesize badges = _badges;
@synthesize points = _points;

- (void)assignValuesFromDictionary:(NSDictionary *)dict {
	self.userID = [[dict objectForKey:@"id"] stringValue];
	self.groupType = [dict objectForKey:@"group"];
	self.userName = [dict objectForKey:@"name"];
	self.imageUrl = [dict objectForKey:@"image"];
	
	id object;
	if((object = [Utility objectNotNSNull:[dict objectForKey:@"followers"]]) != nil)
		self.followers = [object intValue];
	if((object = [Utility objectNotNSNull:[dict objectForKey:@"following"]]) != nil)
		self.following = [object intValue];
	if((object = [Utility objectNotNSNull:[dict objectForKey:@"checkins"]]) != nil)
		self.checkins = [object intValue];
	if((object = [Utility objectNotNSNull:[dict objectForKey:@"badges"]]) != nil)
		self.badges = [object intValue];
	if((object = [Utility objectNotNSNull:[dict objectForKey:@"points"]]) != nil)
		self.points = [object intValue];
}

- (void)dealloc {
	[_userID release];
	[_groupType release];
	[_userName release];
	[_imageUrl release];
	[_image release];
	[super dealloc];
}

@end
