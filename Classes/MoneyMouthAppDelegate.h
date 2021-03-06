//
//  MoneyMouthAppDelegate.h
//  MoneyMouth
//
//  Created by Todd Fearn on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "FlurryAPI.h"
#import "Globals.h"
#import "FacebookLoginViewController.h"

@interface MoneyMouthAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	Facebook *facebook;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) Facebook *facebook;

@end
