//
//  BaseUserListViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "BaseViewController.h"
#import "UserViewController.h"
#import "ImageManager.h"
#import "User.h"

@interface BaseUserListViewController : BaseViewController <ASIHTTPRequestDelegate, ImageManagerDelegate> {
	IBOutlet UITableView *_tableView;
	ASIHTTPRequest *_request;
	ImageManager *_imageManager;
	NSMutableArray *_users;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, retain) ImageManager *imageManager;
@property (nonatomic, retain) NSMutableArray *users;

- (void)getUrl:(NSString *)url;
- (NSString *)getReturnedDataJSONRoot;

@end