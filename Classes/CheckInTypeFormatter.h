//
//  CheckInTypeFormatter.h
//  Finster
//
//  Created by Todd Fearn on 5/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Globals.h"

@interface CheckInTypeFormatter : NSObject {
	NSString *_formattedValue;
}
@property (nonatomic, retain) NSString *formattedValue;

- (NSString *)format:(int)checkInType symbol:(NSString *)symbol;

@end
