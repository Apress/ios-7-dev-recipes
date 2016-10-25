//
//  EditWordViewController.h
//  Recipe 15-3 Using Core Data
//
//  Created by joseph hoffman on 9/3/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"

@class EditWordViewController;

typedef void (^EditWordViewControllerCompletionHandler)(EditWordViewController *sender, BOOL canceled);

@interface EditWordViewController : UIViewController
{
@private
    EditWordViewControllerCompletionHandler _completionHandler;
    Word *_word;
}

@property (weak, nonatomic) IBOutlet UITextField *wordTextField;
@property (weak, nonatomic) IBOutlet UITextField *translationTextField;


- (id)initWithWord:(Word *)word
        completion:(EditWordViewControllerCompletionHandler)completionHandler;

+ (void)editWord:(Word *)word
inNavigationController:(UINavigationController *)navigationController
      completion:(EditWordViewControllerCompletionHandler)completionHandler;

@end
