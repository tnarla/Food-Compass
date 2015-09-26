//
//  FoodTableViewCell.h
//  Food Compass
//
//  Created by Trushitha Narla on 9/26/15.
//  Copyright © 2015 Trushitha Narla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeImage;
@property (weak, nonatomic) IBOutlet UIImageView *miniCompassImage;

@end
