//
//  ViewController.h
//  Recipe 15-5 Storing UIDocuments in iCloud
//
//  Created by joseph hoffman on 9/4/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDocument.h"

@interface ViewController : UIViewController <MyDocumentDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *fontSizeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextView *documentTextView;
@property (strong, nonatomic) NSUbiquitousKeyValueStore *iCloudKeyValueStore;
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) MyDocument *document;
@property (strong, nonatomic) NSURL *documentURL;

- (IBAction)saveDocument:(id)sender;
- (IBAction)updateTextSize:(id)sender;
@end
