//
//  FacebookLoginViewController.h
//  Finster
//
//  Created by Todd Fearn on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "Globals.h"
#import "BaseViewController.h"
#import "Request.h"

@interface FacebookLoginViewController : BaseViewController <FBSessionDelegate, FBRequestDelegate, RequestDelegate> {
	IBOutlet UIButton *_loginFacebookButton;
	Facebook *_facebook;
	Request *_loginUsingFacebookRequest;
}
@property (nonatomic, retain) UIButton *loginFacebookButton;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) Request *loginUsingFacebookRequest;

- (IBAction)loginWithFacebookButtonPressed:(id)sender;

@end
