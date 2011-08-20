//
//  Utility.h
//  HedgeHog
//
//  Created by Todd Fearn on 3/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject {

}

+ (id)objectNotNSNull:(id)object;
+ (NSString *)getXMLSubsection:(NSString *)source startXML:(NSString *)startXML endXML:(NSString *)endXML;
+ (NSDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array;

@end
