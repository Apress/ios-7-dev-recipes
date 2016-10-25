//
//  ViewController.h
//  Recipe 15-4 Storing Key-Value Data in iCloud
//
//  Created by joseph hoffman on 9/4/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *fontSizeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextView *documentTextView;
@property (strong, nonatomic) NSUbiquitousKeyValueStore *iCloudKeyValueStore;
@property (strong, nonatomic) NSUserDefaults *userDefaults;

- (IBAction)updateTextSize:(id)sender;

- (IBAction)saveDocument:(id)sender;
@end
