//
//  LoginViewController.h
//  iPRIME
//
//  Created by Todd Fearn on 12/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Globals.h"
#import "BaseViewController.h"
#import "Request.h"

@interface LoginViewController : BaseViewController <RequestDelegate> {
	IBOutlet UITextField *_username;
	IBOutlet UITextField *_password;
	Request *_request;
}
@property (nonatomic, retain) UITextField *username;
@property (nonatomic, retain) UITextField *password;
@property (nonatomic, retain) Request *request;

- (IBAction)signInPressed:(id)selector;
- (IBAction)forgotPressed:(id)selector;

@end
