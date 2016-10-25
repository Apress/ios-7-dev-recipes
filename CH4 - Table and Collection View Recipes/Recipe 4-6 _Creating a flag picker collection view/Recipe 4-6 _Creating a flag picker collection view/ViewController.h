//
//  ViewController.h
//  Recipe 4-6 :Creating a flag picker collection view
//
//  Created by joseph hoffman on 7/13/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlagPickerViewController.h"

@interface ViewController : UIViewController <FlagPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;

- (IBAction)pickFlag:(id)sender;

@end
