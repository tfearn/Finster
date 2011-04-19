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
	NSString *_userName;
	NSURL *_imageUrl;
}
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSURL *imageUrl;

@end
