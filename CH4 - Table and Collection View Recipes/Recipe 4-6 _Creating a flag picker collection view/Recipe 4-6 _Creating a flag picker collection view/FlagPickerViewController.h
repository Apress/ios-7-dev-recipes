//
//  FlagPickerViewController.h
//  Recipe 4-6 :Creating a flag picker collection view
//
//  Created by joseph hoffman on 7/13/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flag.h"

@class FlagPickerViewController;

@protocol FlagPickerViewControllerDelegate <NSObject>

-(void)flagPicker:(FlagPickerViewController *)flagPicker didPickFlag:(Flag *)flag;

@end

@interface FlagPickerViewController : UICollectionViewController
{
@private
NSArray *africanFlags;
NSArray *asianFlags;
NSArray *australasianFlags;
NSArray *europeanFlags;
NSArray *northAmericanFlags;
NSArray *southAmericanFlags;
}

- (id)initWithDelegate:(id<FlagPickerViewControllerDelegate>)delegate;

@property (weak, nonatomic)id<FlagPickerViewControllerDelegate>delegate;


@end
