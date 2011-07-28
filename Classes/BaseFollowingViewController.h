//
//  BaseFollowingViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "BaseViewController.h"
#import "BaseUserViewController.h"
#import "ImageManager.h"
#import "User.h"

@interface BaseFollowingViewController : BaseViewController <ASIHTTPRequestDelegate, ImageManagerDelegate> {
	IBOutlet UITableView *_tableView;
	ASIHTTPRequest *_request;
	ImageManager *_imageManager;
	NSMutableArray *_users;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) ImageManager *imageManager;
@property (nonatomic, retain) NSMutableArray *users;

- (NSURL *)getUrl;
- (NSString *)getReturnedDataRootKey;

@end
