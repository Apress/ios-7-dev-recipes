//
//  ViewController.m
//  Recipe 15-5 Storing UIDocuments in iCloud
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
    
        [self updateDocument];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveDocument:(id)sender
{
    if (self.document)
    {
        self.document.text = self.documentTextView.text;
        [self.document saveToURL:self.documentURL
                forSaveOperation:UIDocumentSaveForOverwriting completionHandler:
         ^(BOOL success)
         {
             if (success)
             {
                 NSLog(@"Written to iCloud");
             }
             else
             {
                 NSLog(@"Error writing to iCloud");
             }
         }];
    }
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

- (void)updateDocument
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    id iCloudToken = [fileManager ubiquityIdentityToken];
    if (iCloudToken)
    {
        // iCloud available
        
        // Register to notifications for changes in availability
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleICloudDidChangeIdentity:)
                                                     name:NSUbiquityIdentityDidChangeNotification object:nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           NSURL *documentContainer = [[fileManager URLForUbiquityContainerIdentifier:nil]
                                                       URLByAppendingPathComponent:@"Documents"];
                           
                           if (documentContainer != nil)
                           {
                               self.documentURL =
                               [documentContainer URLByAppendingPathComponent:@"mydocument.txt"];
                               self.document =
                               [[MyDocument alloc] initWithFileURL:self.documentURL];
                               self.document.delegate = self;
                               // If the file exists, open it; otherwise, create it.
                               if ([fileManager fileExistsAtPath:self.documentURL.path])
                                   [self.document openWithCompletionHandler:nil];
                               else
                                   [self.document saveToURL:self.documentURL
                                           forSaveOperation:UIDocumentSaveForCreating
                                          completionHandler:nil];
                           }
                       });
    }
    else
    {
        // No iCloud access
        self.documentURL = nil;
        self.document = nil;
        self.documentTextView.text = @"<NO iCloud Access>";
    }
}


- (void)handleICloudDidChangeIdentity: (NSNotification *)notification
{
    NSLog(@"ID changed");
    [self updateDocument];
}

- (void)documentDidChange:(MyDocument *)document
{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       self.documentTextView.text = document.text;
                   });
}


@end
