//
//  Request.h
//  Finster
//
//  Created by Todd Fearn on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "Globals.h"

@class Request;

@protocol RequestDelegate <NSObject>
-(void)requestComplete:(NSObject *)data;
-(void)requestFailure:(NSError *)error;
@end

@interface Request : NSObject <NSXMLParserDelegate> {
	id<RequestDelegate> delegate;
	ASIHTTPRequest *_request;
	NSError *_error;
	BOOL active;
}
@property (assign) id<RequestDelegate> delegate;
@property (nonatomic, assign) ASIHTTPRequest *request;	// ASIHttpRequest is autoreleased
@property (nonatomic, retain) NSError *error;

- (void)get:(NSURL *)url;
- (void)post:(NSURL *)url postData:(NSString *)postData;

@end
