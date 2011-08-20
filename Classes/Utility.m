//
//  Utility.m
//  HedgeHog
//
//  Created by Todd Fearn on 3/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Utility.h"


@implementation Utility

+ (id)objectNotNSNull:(id)object {
	if(object == [NSNull null])
		return nil;
	return object;
}

+ (NSString *)getXMLSubsection:(NSString *)source startXML:(NSString *)startXML endXML:(NSString *)endXML {
	
	NSRange startRange =[source rangeOfString:startXML];
	if(startRange.location == NSNotFound)
		return nil;
	
	NSRange endRange =[source rangeOfString:endXML];
	if(endRange.location == NSNotFound)
		return nil;
	
	NSString *subsection = [source substringWithRange:NSMakeRange(startRange.location, endRange.location-startRange.location + [endXML length])];
	
	return subsection;
}

// Create a dictionary from an array. The result is an index dictionary of arrays
//
+ (NSDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array {
	id object;
	
	NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
	for (object in array) {
		NSRange firstCharRange = NSMakeRange(0,1);
		NSString* firstCharacter = [[object description] substringWithRange:firstCharRange];
		firstCharacter = [firstCharacter uppercaseString];
		unichar c = [firstCharacter characterAtIndex:0];
		if(c < 'A' || c > 'Z')
			firstCharacter = @"#";
		
		NSMutableArray *array = [mutableDictionary objectForKey:firstCharacter];
		if(array == nil) {
			array = [[NSMutableArray alloc] init];
			[mutableDictionary setValue:array forKey:firstCharacter];
		}
		[array addObject:object];
	}
	
	return (NSDictionary *)mutableDictionary;
}

@end
