    //
//  ProfileViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"

@class UINavigationButton;

@implementation ProfileViewController
@synthesize scrollView = _scrollView;
@synthesize findFriendsButton = _findFriendsButton;
@synthesize shareAppActionSheet = _shareAppActionSheet;
@synthesize findFriendsActionSheet = _findFriendsActionSheet;
@synthesize lastRequestDate = _lastRequestDate;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	self.scrollView.contentSize = CGSizeMake(320, 450);

	UIBarButtonItem *shareAppButton = [[UIBarButtonItem alloc] initWithTitle:@"Share App" style:UIBarButtonItemStyleBordered target:self action:@selector(shareAppButtonPressed:)];
	self.navigationItem.leftBarButtonItem = shareAppButton; 
	[shareAppButton release];

	UIBarButtonItem *feedbackButton = [[UIBarButtonItem alloc] initWithTitle:@"Feedback" style:UIBarButtonItemStyleBordered target:self action:@selector(feedbackButtonPressed:)];
	self.navigationItem.rightBarButtonItem = feedbackButton; 
	[feedbackButton release];

	// Add notification observers
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCheckIn) name:kNotificationCheckIn object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationFollowingUnfollowing) name:kNotificationFollowingUnfollowing object:nil];
	
	viewDirty = YES;
	
/*
	// Set the nav bar buttons to green
	for (UIView *view in self.navigationController.navigationBar.subviews) {
		MyLog(@"%@", [[view class] description]);
		if ([[[view class] description] isEqualToString:@"UINavigationButton"]) {
			[(UINavigationButton *)view setTintColor:[UIColor greenColor]];
		}
	} 
*/
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	// Is this me?
	if(self.user == nil && self.user.userID == nil) {
		self.isYou = YES;
	}
	else if(self.user != nil) {
		if([self.user.groupType caseInsensitiveCompare:@"you"] == NSOrderedSame)
			self.isYou = YES;
	}
	
	if(self.lastRequestDate != nil) {
		// If we haven't had an update in over 1 minute, automatically refresh
		NSDate *now = [NSDate date];
		if([now timeIntervalSince1970] - [self.lastRequestDate timeIntervalSince1970] > (1*60))
			viewDirty = YES;
	}
	
	if(viewDirty) {
		[self getData];
		
		// TODO: this should be in the base class upon a successful request.
		// Setup a method to call from the base that this class will handle upon success
		viewDirty = NO;
		self.lastRequestDate = [NSDate date];
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationCheckIn object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationFollowingUnfollowing object:nil];

	[_scrollView release];
	[_findFriendsButton release];
	[_shareAppActionSheet release];
	[_findFriendsActionSheet release];
	[_lastRequestDate release];
    [super dealloc];
}

- (void)notificationCheckIn {
	viewDirty = YES;
}

- (void)notificationFollowingUnfollowing {
	viewDirty = YES;
}

- (IBAction)shareAppButtonPressed:(id)sender {
	_shareAppActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share App with Friends", nil];
	self.shareAppActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[self.shareAppActionSheet showFromTabBar:self.tabBarController.tabBar];
	[self.shareAppActionSheet release];
}

- (IBAction)feedbackButtonPressed:(id)sender {
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	NSArray *toList = [[[NSArray alloc] initWithObjects:kEmailFinsterFeedback, nil] autorelease];
	[controller setToRecipients:toList]; 
	[controller setSubject:@"Finster Feedback"];
	[controller setMessageBody:@"My thoughts/recommendations regarding Finster:" isHTML:NO]; 
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

- (IBAction)findFriendsButtonPressed:(id)sender {
	FindFriendsOnAppViewController *controller = [[FindFriendsOnAppViewController alloc] init];
	[controller setHidesBottomBarWhenPushed:YES];
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];	
}

#pragma mark -
#pragma mark UIActionSheetDelegate Methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(actionSheet == _shareAppActionSheet) {
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
