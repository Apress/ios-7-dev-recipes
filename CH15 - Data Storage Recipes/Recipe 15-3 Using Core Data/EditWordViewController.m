//
//  EditWordViewController.m
//  Recipe 15-3 Using Core Data
//
//  Created by joseph hoffman on 9/3/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "EditWordViewController.h"

@interface EditWordViewController ()

@end

@implementation EditWordViewController

- (id)initWithWord:(Word *)word completion:(EditWordViewControllerCompletionHandler)completionHandler
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _completionHandler = completionHandler;
        _word = word;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Edit Word";
    
    self.wordTextField.text = _word.word;
    self.translationTextField.text = _word.translation;
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                  target:self action:@selector(cancel)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)editWord:(Word *)word
inNavigationController:(UINavigationController *)navigationController
      completion:(EditWordViewControllerCompletionHandler)completionHandler
{
    EditWordViewController *editViewController =
    [[EditWordViewController alloc] initWithWord:word completion:completionHandler];
    [navigationController pushViewController:editViewController animated:YES];
}
- (void)done
{
    _word.word = self.wordTextField.text;
    _word.translation = self.translationTextField.text;
    _completionHandler(self, NO);
}
- (void)cancel
{
    _completionHandler(self, YES);
}


@end
