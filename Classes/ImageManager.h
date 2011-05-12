//
//  ImageManager.h
//  Finster
//
//  Created by Todd Fearn on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "Image.h"

@class ImageManager;

@protocol ImageManagerDelegate <NSObject>
-(void)imageRequestComplete:(Image *)image;
-(void)imageRequestFailure:(NSString *)url;
@end

@interface ImageManager : NSObject {
	id<ImageManagerDelegate> _delegate;
	NSOperationQueue *_queue;	// Used to retrieve images
}
@property (assign) id<ImageManagerDelegate> delegate;
@property (nonatomic, retain) NSOperationQueue *queue;

- (Image *)getImage:(NSString *)url;

@end
