//
//  TimePassedFormatter.h
//  Finster
//
//  Created by Todd Fearn on 5/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TimePassedFormatter : NSObject {
	NSString *_formattedValue;
}
@property (nonatomic, retain) NSString *formattedValue;

- (NSString *)format:(NSDate *)date;

@end
