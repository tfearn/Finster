//
//  Image.h
//  Finster
//
//  Created by Todd Fearn on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Image : NSObject {
	NSString *_url;
	UIImage *_image;
	BOOL _requestOutstanding;
}
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) UIImage *image;
@property BOOL requestOutstanding;
@end
