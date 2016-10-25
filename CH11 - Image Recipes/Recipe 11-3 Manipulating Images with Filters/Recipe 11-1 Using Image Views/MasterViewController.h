//
//  MasterViewController.h
//  Recipe 11-3 Manipulating Images with Filters
//
//  Created by joseph hoffman on 8/29/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import "DetailViewController.h"

@interface MasterViewController : UITableViewController <DetailViewControllerDelegateProtocol>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, strong) UIImage *mainImage;
@property (strong, nonatomic) NSMutableArray *filteredImages;

@end
