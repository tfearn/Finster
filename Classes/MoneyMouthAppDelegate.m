//
//  MoneyMouthAppDelegate.m
//  MoneyMouth
//
//  Created by Todd Fearn on 4/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoneyMouthAppDelegate.h"

@interface MoneyMouthAppDelegate (Private)
- (BOOL)initializeDatabase;
- (void)doFacebookLogin;
- (void)doLogin;
@end


@implementation MoneyMouthAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize facebook;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

	// Start Flurry
	[FlurryAPI startSession:@"MHXFBN6F4EUFT6BSXB9Z"];
	[FlurryAPI logAllPageViews:tabBarController];
	
    // Add the tab bar controller's view to the window and display.
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];

	// Login via Facebook
	[self doFacebookLogin];
	
	// Initialize the Db
	if(! [self initializeDatabase]) {
		// TODO:  We have problems here, fix
		return NO;
	}
	
    // Leave the splash view in place for a little while
    [NSThread sleepForTimeInterval: kStartupDelay];

	return YES;
}


- (BOOL)initializeDatabase {
	
	// If the database does not exist, copy it from the bundle to the documents path
	//
	
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [[searchPaths objectAtIndex:0] stringByAppendingPathComponent:kDatabaseFilename];
    if(! [[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
		
		NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"finster" ofType:@"sqlite"];
		if(bundlePath == nil) {
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Internal Error" message:@"Could not find database inside bundle." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
			[alert show];
			return NO;
		}
		
        if(! [[NSFileManager defaultManager] copyItemAtPath:bundlePath toPath:documentsPath error:nil]) {
			UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Internal Error" message:@"Could not copy database from bundle." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
			[alert show];
			return NO;
		}
	}
	
	// Open the database
	MyLog(@"Local database file: %@", documentsPath);
	NSError *error = [Globals openDatabase:documentsPath];
	if(error != nil) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Internal Database Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		return NO;
	}
	
	return YES;
}


- (void)doFacebookLogin {
	// initialize FBConnect
	facebook = [[Facebook alloc] initWithAppId:kFacebookAppID];
	facebook.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:kFacebookAccessTokenKey];
    facebook.expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:kFacebookExpirationDateKey];
	
	FacebookLoginViewController *viewController = [[FacebookLoginViewController alloc] init];
	viewController.facebook = facebook;
    [self.tabBarController presentModalViewController: viewController animated: NO];
	[viewController release];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


// Required by FBConnect
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [facebook handleOpenURL:url]; 
}


#pragma mark -
#pragma mark UITabBarControllerDelegate methods

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [tabBarController release];
    [window release];
	[facebook release];
    [super dealloc];
}

@end

