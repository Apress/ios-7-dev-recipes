//
//  ViewController.m
//  Recipe 14-7 Accessing the Address Book
//
//  Created by joseph hoffman on 8/30/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions
- (IBAction)pickContact:(id)sender
{
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - delegate methods

-(BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
     shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    self.firstNameLabel.text =
    (__bridge_transfer NSString *)ABRecordCopyValue(person,
                                                    kABPersonFirstNameProperty);
    
    self.lastNameLabel.text =
    (__bridge_transfer NSString *)ABRecordCopyValue(person,
                                                    kABPersonLastNameProperty);
    
    ABMultiValueRef phoneRecord = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFStringRef phoneNumber = ABMultiValueCopyValueAtIndex(phoneRecord, 0);
    self.phoneNumberLabel.text = (__bridge_transfer NSString *)phoneNumber;
    CFRelease(phoneRecord);
    
    ABMultiValueRef addressRecord = ABRecordCopyValue(person, kABPersonAddressProperty);
    if (ABMultiValueGetCount(addressRecord) > 0)
    {
        CFDictionaryRef addressDictionary =
        ABMultiValueCopyValueAtIndex(addressRecord, 0);
        self.cityNameLabel.text =
        [NSString stringWithString:
         (__bridge NSString *)CFDictionaryGetValue(addressDictionary,
                                                   kABPersonAddressCityKey)];
        CFRelease(addressDictionary);
    }
    else
    {
        self.cityNameLabel.text = @"...";
    }
    CFRelease(addressRecord);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}


@end
