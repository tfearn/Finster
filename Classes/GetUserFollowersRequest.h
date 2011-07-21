//
//  GetUserFollowersRequest.h
//  Finster
//
//  Created by Todd Fearn on 7/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"

@interface GetUserFollowersRequest : Request {
	NSMutableArray *_users;
}
@property (nonatomic, retain) NSMutableArray *users;

- (void)get:(NSString *)url;

@end
