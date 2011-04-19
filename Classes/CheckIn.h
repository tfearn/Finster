//
//  CheckIn.h
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface CheckIn : NSObject {
	NSString *_checkinID;
	NSDate *_timestamp;
	int _checkinType;
	User *_user;
	NSString *_comment;
}
@property (nonatomic, retain) NSString *checkinID;
@property (nonatomic, retain) NSDate *timestamp;
@property int checkinType;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSString *comment;

@end
