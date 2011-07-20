//
//  CheckInRequest.h
//  Finster
//
//  Created by Todd Fearn on 7/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"

@interface CheckInRequest : Request {
	int _badgeID;
	int _checkInsForTicker;
	int _otherCheckInsForTicker;
	int _otherTickerInterest;
	int _pointsEarned;
	int _totalPoints;
}
@property int badgeID;
@property int checkInsForTicker;
@property int otherCheckInsForTicker;
@property int otherTickerInterest;
@property int pointsEarned;
@property int totalPoints;

- (void)get:(NSString *)url;

@end
