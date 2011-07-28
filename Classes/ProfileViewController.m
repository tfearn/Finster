    //
//  ProfileViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"


@implementation ProfileViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	UIBarButtonItem *shareAppButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAppButtonPressed:)];
	self.navigationItem.leftBarButtonItem = shareAppButton; 
	[shareAppButton release];

	UIBarButtonItem *feedbackButton = [[UIBarButtonItem alloc] initWithTitle:@"Feedback" style:UIBarButtonItemStyleBordered target:self action:@selector(feedbackButtonPressed:)];
	self.navigationItem.rightBarButtonItem = feedbackButton; 
	[feedbackButton release];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
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
    [super dealloc];
}

- (IBAction)shareAppButtonPressed:(id)sender {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share App with Friends", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[actionSheet showFromTabBar:self.tabBarController.tabBar];
	[actionSheet release];
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
