//
//  GetWallRequest.h
//  Finster
//
//  Created by Todd Fearn on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "Globals.h"
#import "CheckIn.h"

@class GetWallRequest;

@protocol GetWallRequestDelegate <NSObject>
-(void)getWallRequestComplete:(GetWallRequest *)getWallRequest;
-(void)getWallRequestFailure:(GetWallRequest *)getWallRequest;
@end

@interface GetWallRequest : NSObject <NSXMLParserDelegate> {
	id<GetWallRequestDelegate> delegate;
	ASIHTTPRequest *_request;
	NSMutableArray *_checkIns;
}
@property (assign) id<GetWallRequestDelegate> delegate;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) NSMutableArray *checkIns;

- (void)doRequest;

@end
