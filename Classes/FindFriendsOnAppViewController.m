    //
//  FindFriendsOnAppViewController.m
//  Finster
//
//  Created by Todd Fearn on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FindFriendsOnAppViewController.h"


@implementation FindFriendsOnAppViewController
@synthesize searchBar = _searchBar;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"Find Friends";	
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
	[_searchBar release];
    [super dealloc];
}

- (NSString *)getReturnedDataJSONRoot {
	return @"searchresults";
}

#pragma mark -
#pragma mark UISearchBarDelegate Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	NSString *search = searchBar.text;
	
	if([search length]) {
		[searchBar resignFirstResponder];
		
		NSString *url = [NSString stringWithFormat:kUrlFindUser, search];
		NSString* escapedUrl =[url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		[self getUrl:escapedUrl];
	}
}


@end
