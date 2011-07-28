//
//  BaseUserViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "SBJSON.h"
#import "Globals.h"
#import "ImageManager.h"
#import "BaseViewController.h"
#import "User.h"

@interface BaseUserViewController : BaseViewController <ASIHTTPRequestDelegate, ImageManagerDelegate> {
	IBOutlet UITableView *_tableView;
	IBOutlet UIImageView *_userImageView;
	IBOutlet UILabel *_username;
	NSOperationQueue *_queue;
	ImageManager *_imageManager;
	User *_user;
}
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIImageView *userImageView;
@property (nonatomic, retain) UILabel *username;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) ImageManager *imageManager;
@property (nonatomic, retain) User *user;

@end
