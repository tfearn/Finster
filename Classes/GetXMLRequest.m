//
//  GetXMLRequest.m
//  Finster
//
//  Created by Todd Fearn on 4/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetXMLRequest.h"

@interface GetXMLRequest (Private)
- (void)parseData:(NSData *)data;
@end


@implementation GetXMLRequest
@synthesize delegate;
@synthesize request = _request;
@synthesize error = _error;

- (void)doRequest:(NSURL *)url {
	_request = [ASIHTTPRequest requestWithURL:url];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
}

- (void)dealloc {
	if(self.request != nil)
		[self.request clearDelegatesAndCancel];
	
	[_request release];
	[_error release];
	[super dealloc];
}

- (NSObject *)getParsedDataObject {
	// empty
	return nil;
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	// Parse the return data
	[self parseData:[request responseData]];
	
	// Grab the data object from the subclass
	NSObject *data = [self getParsedDataObject];
	
	// Call the delegate
	if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(getXMLRequestComplete:)]) {
		[self.delegate getXMLRequestComplete:data];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	self.error = [request error];
	
	// Call the delegate
	if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(getXMLRequestFailure:)]) {
		[self.delegate getXMLRequestFailure:self.error];
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
