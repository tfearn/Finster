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


@interface FacebookLoginViewController : BaseViewController <FBSessionDelegate, FBRequestDelegate> {
	IBOutlet UIButton *_loginFacebookButton;
	Facebook *_facebook;
}
@property (nonatomic, retain) UIButton *loginFacebookButton;
@property (nonatomic, retain) Facebook *facebook;

- (IBAction)loginWithFacebookButtonPressed:(id)sender;

@end
