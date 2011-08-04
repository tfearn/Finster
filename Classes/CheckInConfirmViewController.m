    //
//  CheckInConfirmViewController.m
//  Finster
//
//  Created by Todd Fearn on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckInConfirmViewController.h"

#define kTextViewDefaultMessage		@"Add a comment..."

@implementation CheckInConfirmViewController
@synthesize textView = _textView;
@synthesize facebookImageView = _facebookImageView;
@synthesize twitterImageView = _twitterImageView;
@synthesize facebookButton = _facebookButton;
@synthesize twitterButton = _twitterButton;
@synthesize request = _request;
@synthesize jsonParser = _jsonParser;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.textView setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];

	// Initialize the JSON parser
	self.jsonParser = [[SBJSON alloc] init];
	
	// Default Facebook share on
	facebookOn = YES;
	
	// Add a notification observer for check-in complete
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewFilterChanged) name:kNotificationCheckInComplete object:nil];
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
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationCheckInComplete object:nil];

	[_textView release];
	[_facebookImageView release];
	[_twitterImageView release];
	[_facebookButton release];
	[_twitterButton release];
	[_jsonParser release];
    [super dealloc];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
	[textView setText:@""];
	commentExists = YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
		
		if([self.textView.text length] == 0)
			self.textView.text = kTextViewDefaultMessage;
		
        return FALSE;
    }

    return TRUE;
}

- (IBAction)facebookButtonPressed:(id)sender {
	facebookOn = ! facebookOn;
	if(facebookOn)
		self.facebookImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"facebook-icon" ofType:@"png"]];
	else
		self.facebookImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"facebook-grey-icon" ofType:@"png"]];
}

- (IBAction)twitterButtonPressed:(id)sender {
	twitterOn = ! twitterOn;
	if(twitterOn)
		self.twitterImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"twitter-icon" ofType:@"png"]];
	else
		self.twitterImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"twitter-grey-icon" ofType:@"png"]];
}

- (IBAction)checkInButtonPressed:(id)sender {

	// Do the check in request
	//
	NSString *urlString = [NSString stringWithFormat:kUrlPostCheckIn, self.checkInType, self.ticker.symbol, self.ticker.symbolName, self.ticker.typeName];
	if(self.ticker.exchangeName != nil)
		urlString = [urlString stringByAppendingFormat:@"&exchange=%@", self.ticker.exchangeName];
	if([[self.textView text] length]) {
		if([[self.textView text] isEqualToString:kTextViewDefaultMessage] == NO)
			urlString = [urlString stringByAppendingFormat:@"&comment=%@", [self.textView text]];
	}
	if(facebookOn)
		urlString = [urlString stringByAppendingString:@"&sharefacebook=1"];
	if(twitterOn)
		urlString = [urlString stringByAppendingString:@"&sharetwitter=1"];
	NSString* escapedUrlString =[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	MyLog(@"%@", escapedUrlString);
	
	[self showWaitView:@"Checking in..."];

	_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:escapedUrlString]];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
}

#pragma mark -
#pragma mark ASIHttpRequestDelegate Methods

- (void)requestFinished:(ASIHTTPRequest *)request {
	[self dismissWaitView];

	NSString *response = [request responseString];
	
	// Parse the data
	NSError *error = nil;
	NSDictionary *dict = [self.jsonParser objectWithString:response error:&error];
	if(error != nil) {
		NSLog(@"Parser Error: %@", [error description]);
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		return;
	}
	
	CheckInResult *checkInResult = [[CheckInResult alloc] init];
	checkInResult.badgeID = [[dict objectForKey:@"badgeID"] intValue];
	checkInResult.checkInsForTicker = [[dict objectForKey:@"checkInsForTicker"] intValue];
	checkInResult.otherCheckInsForTicker = [[dict objectForKey:@"otherCheckInsForTicker"] intValue];
	checkInResult.otherTickerInterest = [[dict objectForKey:@"otherTickerInterest"] intValue];
	checkInResult.pointsEarned = [[dict objectForKey:@"pointsEarned"] intValue];
	checkInResult.totalPoints = [[dict objectForKey:@"totalPoints"] intValue];

	// Launch the CheckInResultView
	CheckInResultViewController *controller = [[CheckInResultViewController alloc] init];
	controller.ticker = self.ticker;
	controller.checkInType = self.checkInType;
	controller.checkInResult = checkInResult;
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
	
	[checkInResult release];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	[self dismissWaitView];

	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:[[request error] description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
	[alert show];
}

@end
