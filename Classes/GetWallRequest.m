//
//  GetWallRequest.m
//  Finster
//
//  Created by Todd Fearn on 4/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetWallRequest.h"


@implementation GetWallRequest
@synthesize delegate;
@synthesize request = _request;
@synthesize checkIns = _checkIns;

- (void)doRequest {
	NSURL *url = [NSURL URLWithString:kUrlGetWall];
	_request = [ASIHTTPRequest requestWithURL:url];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
}

- (void)dealloc {
	[_request release];
	[_checkIns release];
	[super dealloc];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *responseString = [request responseString];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSError *error = [request error];
}


@end
