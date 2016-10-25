//
//  ViewController.m
//  Recipe 15-4 Storing Key-Value Data in iCloud
//
//  Created by joseph hoffman on 9/4/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.iCloudKeyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleStoreChange:)
                                                 name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                               object:self.iCloudKeyValueStore];
    
    [self.iCloudKeyValueStore synchronize];
    [self updateUserInterfaceWithPreferences];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateTextSize:(id)sender
{
    CGFloat newFontSize;
    switch (self.fontSizeSegmentedControl.selectedSegmentIndex)
    {
        case 1:
            newFontSize = 19;
            break;
        case 2:
            newFontSize = 24;
            break;
            
        default:
            newFontSize = 14;
            break;
    }
    self.documentTextView.font = [UIFont systemFontOfSize:newFontSize];
    // Update Preferences
    NSInteger selectedSize = self.fontSizeSegmentedControl.selectedSegmentIndex;
    [self.userDefaults setDouble:selectedSize forKey:@"TextSize"];
    [self.userDefaults synchronize];

    [self.iCloudKeyValueStore setDouble:selectedSize forKey:@"TextSize"];

}

- (void)handleStoreChange:(NSNotification *)notification
{
    [self updateUserInterfaceWithPreferences];
}

- (void)updateUserInterfaceWithPreferences
{
    NSInteger selectedSize;
    
    if ([self.iCloudKeyValueStore objectForKey:@"TextSize"] != nil)
    {
        // iCloud value exists
        selectedSize = [self.iCloudKeyValueStore doubleForKey:@"TextSize"];
        // Make sure local cache is synced
        [self.userDefaults setDouble:selectedSize forKey:@"TextSize"];
        [self.userDefaults synchronize];
    }
    else
    {
        // iCloud unavailable, use value from local cache
        selectedSize = [self.userDefaults doubleForKey:@"TextSize"];
    }

    self.fontSizeSegmentedControl.selectedSegmentIndex = selectedSize;
    [self updateTextSize:self];
}

@end
