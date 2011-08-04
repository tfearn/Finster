//
//  FindFriendsOnAppViewController.h
//  Finster
//
//  Created by Todd Fearn on 7/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUserListViewController.h"

@interface FindFriendsOnAppViewController : BaseUserListViewController {
	IBOutlet UISearchBar *_searchBar;
}
@property (nonatomic, retain) UISearchBar *searchBar;

@end
