//
//  ViewController.h
//  Recipe 14-8 Setting Contact Information
//
//  Created by joseph hoffman on 8/30/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController : UIViewController <ABNewPersonViewControllerDelegate>

- (IBAction)addNewContact:(id)sender;

@end
