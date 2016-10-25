//
//  MainTableViewController.h
//  Recipe 4-1 to 4-5: Creating UITableViews
//
//  Created by joseph hoffman on 7/11/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"
#import "CountryDetailsViewController.h"

@interface MainTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CountryDetailsViewControllerDelegate>
{
    
    NSIndexPath *selectedIndexPath;
    
}


@property (weak, nonatomic) IBOutlet UITableView *countriesTableView;

@property (strong, nonatomic) NSMutableArray *countries;
@property (strong, nonatomic) NSMutableArray *unitedKingdomCountries;
@property (strong, nonatomic) NSMutableArray *nonUKCountries;

@end
