//
//  FoodTableViewController.h
//  Food Compass
//
//  Created by Trushitha Narla on 9/26/15.
//  Copyright © 2015 Trushitha Narla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewController : UITableViewController

- (IBAction)searchNearest:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@end
