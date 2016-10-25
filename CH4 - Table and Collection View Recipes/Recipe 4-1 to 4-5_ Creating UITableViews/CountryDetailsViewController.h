//
//  CountryDetailsViewsController.h
//  Recipe 4-1 to 4-5: Creating UITableViews
//
//  Created by joseph hoffman on 7/11/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"

/* Forward declaration needed for the protocol to use
 the CountryDetailsViewController type */
@class CountryDetailsViewController;

@protocol CountryDetailsViewControllerDelegate <NSObject>
-(void)countryDetailsViewControllerDidFinish:(CountryDetailsViewController *)sender;
@end

@interface CountryDetailsViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *capitalTextField;
@property (weak, nonatomic) IBOutlet UITextField *mottoTextField;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;

@property (strong, nonatomic) Country *currentCountry;
@property (strong, nonatomic) id<CountryDetailsViewControllerDelegate> delegate;

@end
