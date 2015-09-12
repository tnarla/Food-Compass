//
//  UITableViewController+TableViewController.h
//  Food Compass
//
//  Created by Trushitha Narla on 9/11/15.
//  Copyright (c) 2015 Trushitha Narla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController <UITextFieldDelegate, UISearchBarDelegate, UINavigationControllerDelegate> {
    IBOutlet UISearchBar *searchBar;
}


@end
