//
//  ViewController.m
//  Recipe 14-8 Setting Contact Information
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

- (IBAction)addNewContact:(id)sender
{
    NSString *firstName = @"Joe";
    NSString *lastName = @"Doe";
    NSString *mobileNumber = @"555-5309";
    NSString *street = @"12345 Circle Wave";
    NSString *city = @"Coral Gables";
    NSString *state = @"FL";
    NSString *zip = @"33146";
    NSString *country = @"United States";
    
    ABRecordRef contactRecord = ABPersonCreate();
    
    // Setup first and last name records
    ABRecordSetValue(contactRecord, kABPersonFirstNameProperty, (__bridge_retained CFStringRef)firstName, nil);
    ABRecordSetValue(contactRecord, kABPersonLastNameProperty, (__bridge_retained CFStringRef)lastName, nil);
    
    // Setup phone record
    ABMutableMultiValueRef phoneRecord = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(phoneRecord, (__bridge_retained CFStringRef)mobileNumber,
                                 kABPersonPhoneMobileLabel, NULL);
    ABRecordSetValue(contactRecord, kABPersonPhoneProperty, phoneRecord, nil);
    CFRelease(phoneRecord);
    
    // Setup address record
    ABMutableMultiValueRef addressRecord = ABMultiValueCreateMutable(kABDictionaryPropertyType);
    CFStringRef dictionaryKeys[5];
    CFStringRef dictionaryValues[5];
    dictionaryKeys[0] = kABPersonAddressStreetKey;
    dictionaryKeys[1] = kABPersonAddressCityKey;
    dictionaryKeys[2] = kABPersonAddressStateKey;
    dictionaryKeys[3] = kABPersonAddressZIPKey;
    dictionaryKeys[4] = kABPersonAddressCountryKey;
    dictionaryValues[0] = (__bridge_retained CFStringRef)street;
    dictionaryValues[1] = (__bridge_retained CFStringRef)city;
    dictionaryValues[2] = (__bridge_retained CFStringRef)state;
    dictionaryValues[3] = (__bridge_retained CFStringRef)zip;
    dictionaryValues[4] = (__bridge_retained CFStringRef)country;
    
    CFDictionaryRef addressDictionary = CFDictionaryCreate(kCFAllocatorDefault, (void *)dictionaryKeys, (void *)dictionaryValues, 5, &kCFCopyStringDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    ABMultiValueAddValueAndLabel(addressRecord, addressDictionary, kABHomeLabel, NULL);
    CFRelease(addressDictionary);
    
    ABRecordSetValue(contactRecord, kABPersonAddressProperty, addressRecord, nil);
    CFRelease(addressRecord);
    
    // Display View Controller
    ABNewPersonViewController *view = [[ABNewPersonViewController alloc] init];
    view.newPersonViewDelegate = self;
    view.displayedPerson = contactRecord;
    
    CFRelease(contactRecord);
    
    UINavigationController *newNavigationController = [[UINavigationController alloc] initWithRootViewController:view];
    [self presentViewController:newNavigationController animated:YES completion:nil];
}

-(void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person
{
    if (person == NULL)
    {
        NSLog(@"User Cancelled Creation");
    }
    else
        NSLog(@"Successfully Created New Person");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end