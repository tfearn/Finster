//
//  ImageManager.m
//  Finster
//
//  Created by Todd Fearn on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageManager.h"

static NSMutableDictionary *imagesCache;


@implementation ImageManager
@synthesize delegate = _delegate;
@synthesize queue = _queue;

+ (void)initialize {
	imagesCache = [[NSMutableDictionary alloc] init];
}

- (id)init {
    if (self = [super init]) {
		_queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (Image *)getImage:(NSString *)url {
	
	// Look in the local image cache
	Image *image = [imagesCache objectForKey:url];
	if(image != nil) {
		// If there is an actual image, return it
		if(image.image != nil)
			return image;
		
		// Is there an outstanding request?
		if(image.requestOutstanding)
			return nil;
	}
	
	// Add the image object to the cache and mark as "request outstanding"
	image = [[Image alloc] init];
	image.url = url;
	image.requestOutstanding = YES;
	[imagesCache setObject:image forKey:url];
	
		
	// Add the url to the request queue
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	[request setUserInfo:[NSDictionary dictionaryWithObject:url forKey:@"imageUrl"]];
	[request setDownloadCache:[ASIDownloadCache sharedCache]];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(imageRequestComplete:)];
	[request setDidFailSelector:@selector(imageRequestFailure:)];
	[self.queue addOperation:request];	
	
	return nil;
}

- (void)dealloc {
	// Release all of the outstanding ASIHttpRequests
	NSArray *requests = [self.queue operations];
	for(int i=0; i<[requests count]; i++) {
		ASIHTTPRequest *request = [requests objectAtIndex:i];
		[request clearDelegatesAndCancel];
	}
	
	[_queue release];
	[super dealloc];
}

- (void)imageRequestComplete:(ASIHTTPRequest *)request {
	NSData *data = [request responseData];
	
	NSString *url = [request.userInfo objectForKey:@"imageUrl"];

	Image *image = [imagesCache objectForKey:url];
	NSAssert(image != nil, @"Fatal Error: Image should not equal nil");
	
	image.requestOutstanding = NO;
	UIImage *imageData = [[UIImage alloc] initWithData:data];
	image.image = imageData;
	[imageData release];

	// Call the delegate
	if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(imageRequestComplete:)]) {
		[self.delegate imageRequestComplete:image];
	}
}

- (void)imageRequestFailure:(ASIHTTPRequest *)request {
	NSString *url = [request.userInfo objectForKey:@"imageUrl"];
	
	Image *image = [imagesCache objectForKey:url];
	NSAssert(image != nil, @"Fatal Error: Image should not equal nil");
	
	image.requestOutstanding = NO;
	
	// Call the delegate
	if(self.delegate != NULL && [self.delegate respondsToSelector:@selector(imageRequestFailure:)]) {
		[self.delegate imageRequestFailure:url];
	}
}


@end
