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
@synthesize twitterConnect = _twitterConnect;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.textView setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];

	// Initialize the JSON parser
	_jsonParser = [[SBJSON alloc] init];
	
	// Initialize TwitterConnect
	_twitterConnect = [[TwitterConnect alloc] init];
	_twitterConnect.delegate = self;
	
	// Default Facebook share on
	facebookOn = YES;

	// Default Twitter share on?
	if([Globals isTwitterConfigured]) {
		twitterOn = YES;
		self.twitterImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"twitter-icon" ofType:@"png"]];
	}

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
	
	if(self.request != nil)
		[_request clearDelegatesAndCancel];

	[_textView release];
	[_facebookImageView release];
	[_twitterImageView release];
	[_facebookButton release];
	[_twitterButton release];	
	[_jsonParser release];
	[_twitterConnect release];
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
	
	// If Twitter is not configured, and we're going to Twitter = YES, we 
	// must configure Twitter before proceeding
	if([Globals isTwitterConfigured] == NO && twitterOn == NO) {
		[_twitterConnect authorize:self.navigationController];
	}
	else {
		twitterOn = ! twitterOn;
		if(twitterOn)
			self.twitterImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"twitter-icon" ofType:@"png"]];
		else
			self.twitterImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"twitter-grey-icon" ofType:@"png"]];
	}
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
	NSString* escapedUrlString =[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	MyLog(@"%@", escapedUrlString);
	
	[self showWaitView:@"Checking in..."];

	_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:escapedUrlString]];
	[self.request setDelegate:self];
	[self.request startAsynchronous];
	
	// Tweet the check-in?
	if(twitterOn) {
		CheckInTypeFormatter *formatter = [[[CheckInTypeFormatter alloc] init] autorelease];
		NSString *message = [formatter format:self.checkInType symbol:self.ticker.symbol];

		if([[self.textView text] isEqualToString:kTextViewDefaultMessage] == NO)
			message = [message stringByAppendingFormat:@" '%@'", [self.textView text]];
		
		message = [message stringByAppendingString:@" via @finsterapp"];
		[_twitterConnect tweet:message];
	}
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
		[Globals logError:error name:@"JSON_Parser_Error" detail:response];
		
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"JSON Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
		[alert show];
		
		_request = nil;
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
	
	_request = nil;
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	[self dismissWaitView];

	[Globals showNetworkError:request.error];

	_request = nil;
}

#pragma mark -
#pragma mark TwitterConnectDelegate Methods

- (void)twitterConnectSucceeded {
	twitterOn = YES;
	self.twitterImageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"twitter-icon" ofType:@"png"]];
}	
	
- (void)twitterConnectFailed {
	// do nothing at this time
}	

@end
