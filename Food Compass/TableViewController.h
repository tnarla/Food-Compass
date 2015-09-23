//
//  UITableViewController+TableViewController.h
//  Food Compass
//
//  Created by Trushitha Narla on 9/11/15.
//  Copyright (c) 2015 Trushitha Narla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UITextFieldDelegate, UISearchBarDelegate, UINavigationControllerDelegate> {
    IBOutlet UISearchBar *uiSearchBar;
}
@property (weak, nonatomic) IBOutlet UITextField *searchBar;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
