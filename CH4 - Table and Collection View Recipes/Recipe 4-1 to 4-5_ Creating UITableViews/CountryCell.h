//
//  CountryCell.h
//  Recipe 4-1 to 4-5: Creating UITableViews
//
//  Created by joseph hoffman on 7/13/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"

@interface CountryCell : UITableViewCell

@property (strong,nonatomic) Country *country;

@end
