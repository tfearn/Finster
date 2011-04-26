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
- (void)parseData:(NSData *)data;
@end


@implementation Request
@synthesize delegate;
@synthesize request = _request;
@synthesize error = _error;

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
	if([data length]) {
		// Parse the return data
		[self parseData:data];

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
		[self.delegate requestFailure:self.error];
	}
}

#pragma mark XML Parsing

- (void)parseData:(NSData *)data {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	
    [parser setDelegate:self]; // The parser calls methods in this class
    [parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
    [parser setShouldReportNamespacePrefixes:NO]; 
    [parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
	
    [parser parse]; // Parse that data..
	[parser release];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	// empty
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	// empty
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	// empty
}

@end
