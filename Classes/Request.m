//
//  Requester.m
//  Finster
//
//  Created by Todd Fearn on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Request.h"

@interface Request (Private)
- (void)doRequest;
@end


@implementation Request
@synthesize delegate;
@synthesize request = _request;
@synthesize error = _error;
@synthesize parseResponse = _parseResponse;
@synthesize jsonParser = _jsonParser;

-(id)init {
    if ( self = [super init] ) {

		// Setup the JSON Parser
		_jsonParser = [[SBJSON alloc] init];
    }
    return self;
}

- (void)get:(NSURL *)url {
	_request = [ASIHTTPRequest requestWithURL:url];
	[self doRequest];
}

- (void)post:(NSURL *)url postData:(NSString *)postData {
	_request = [ASIHTTPRequest requestWithURL:url];
	
	if(postData != nil)
		[self.request appendPostData:[postData dataUsingEncoding:NSUTF8StringEncoding]];
	[self doRequest];
}

- (void)dealloc {
	if(self.request != nil && active)
		[self.request clearDelegatesAndCancel];
	
	[_error release];
	[_jsonParser release];
	[super dealloc];
}

- (void)doRequest {
	active = YES;
	
	[self.request setUsername:[Globals getUsername]];
	[self.request setPassword:[Globals getPassword]];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
}

- (NSObject *)getParsedDataObject {
	// empty
	return nil;
}

- (void)foundObject:(NSDictionary *)dict {
	// empty
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	active = NO;
	
	NSString *responseString = [request responseString];
	
	NSObject *parsedData = nil;
	if(self.parseResponse && [responseString length]) {
		MyLog(@"%@", responseString);
		
		// Parse the data
		NSError *error = nil;
		NSDictionary *object = [self.jsonParser objectWithString:responseString error:&error];
		if(error != nil) {
			MyLog(@"JSON Parser Error: %@", [error description]);
			
			if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(requestFailure:)]) {
				[self.delegate requestFailure:[error description]];
			}
			return;
		}
		
		[self foundObject:object];
		
		// Grab the data object from the subclass
		parsedData = [self getParsedDataObject];
	}
	
	// Call the delegate
	if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(requestComplete:)]) {
		[self.delegate requestComplete:parsedData];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	active = NO;
	
	self.error = [request error];
	
	// Call the delegate
	if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(requestFailure:)]) {
		[self.delegate requestFailure:[self.error description]];
	}
}

@end
