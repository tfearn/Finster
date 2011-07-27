    //
//  BaseViewController.m
//  HedgeHog
//
//  Created by Todd Fearn on 2/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"


@implementation BaseViewController
@synthesize waitView = _waitView;
@synthesize showShareAppButton = _showShareAppButton;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if(self.showShareAppButton) {
		UIBarButtonItem *shareAppButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAppButtonPressed:)];
		self.navigationItem.leftBarButtonItem = shareAppButton; 
		[shareAppButton release];
	}
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)showWaitView:(NSString *)message {
    _waitView = [[WaitView alloc] initWithMessage: message];
    [self.view addSubview: _waitView];
}

- (void)dismissWaitView {
	if (_waitView) {
		[_waitView removeFromSuperview];
		[_waitView release];
		_waitView = nil;
	}
}

- (void)dealloc {
    [super dealloc];
}

- (IBAction)shareAppButtonPressed:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share App with Friends", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[actionSheet showFromTabBar:self.tabBarController.tabBar];
	[actionSheet release];
}

#pragma mark -
#pragma mark UIActionSheetDelegate Methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == 0) {
		// Share app via e-mail
		MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
		[controller setSubject:@"Finster iPhone App"];
		[controller setMessageBody:@"I found this cool check-in app called Finster! It's basically a check-in app for stocks and very simple to use.  Just type in Finster in the App Store to find it." isHTML:NO]; 
		[self presentModalViewController:controller animated:YES];
		[controller release];
	}
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error;
{
	if (result == MFMailComposeResultSent) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Your e-mail message has been sent" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
	}
	
	if(error != nil) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"E-Mail Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
	}
	
	[self dismissModalViewControllerAnimated:YES];
}

@end
