//
//  User.h
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject {
	NSString *_userID;
	NSString *_groupType;	// you, friend, network
	NSString *_userName;
	NSString *_imageUrl;
	UIImage *_image;
}
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *groupType;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) UIImage *image;

@end
