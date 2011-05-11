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
@synthesize jsonAdapter = _jsonAdapter;

-(id)init {
    if ( self = [super init] ) {

		// Setup the JSON Adapter & Parser
		_jsonAdapter = [SBJsonStreamParserAdapter new];
		self.jsonAdapter.delegate = self;
		
		_jsonParser = [SBJsonStreamParser new];
		self.jsonParser.delegate = self.jsonAdapter;
		self.jsonParser.multi = YES;
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
	[_jsonAdapter release];
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

- (void)requestFinished:(ASIHTTPRequest *)request {
	active = NO;
	
	NSData *data = [request responseData];
	
	NSObject *parsedData = nil;
	if(self.parseResponse && [data length]) {
		MyLog(@"%@", [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease]);
		
		// Parse the data
		SBJsonStreamParserStatus status = [self.jsonParser parse:data];
		if (status == SBJsonStreamParserError) {
			MyLog(@"JSON Parser Error: %@", self.jsonParser.error);

			if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(requestFailure:)]) {
				[self.delegate requestFailure:self.jsonParser.error];
			}
			return;
		}
		
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

#pragma mark -
#pragma mark SBJsonStreamParserAdapterDelegate Methods

- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
	// empty
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
	// empty
}

@end
