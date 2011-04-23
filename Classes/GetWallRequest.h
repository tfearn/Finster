//
//  GetWallRequest.h
//  Finster
//
//  Created by Todd Fearn on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "CheckIn.h"

@interface GetWallRequest : Request {
	NSMutableArray *_checkIns;
	
	// Parsing members
	NSString *lastStartElement;
	CheckIn *checkIn;
}
@property (nonatomic, retain) NSMutableArray *checkIns;

- (void)get;

@end
