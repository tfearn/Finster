//
//  GetRequest.h
//  Finster
//
//  Created by Todd Fearn on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "Globals.h"

@class GetXMLRequest;

@protocol GetXMLRequestDelegate <NSObject>
-(void)getXMLRequestComplete:(NSObject *)data;
-(void)getXMLRequestFailure:(NSError *)error;
@end

@interface GetXMLRequest : NSObject <NSXMLParserDelegate> {
	id<GetXMLRequestDelegate> delegate;
	ASIHTTPRequest *_request;
	NSError *_error;
}
@property (assign) id<GetXMLRequestDelegate> delegate;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) NSError *error;

- (void)doRequest:(NSURL *)url;

@end
