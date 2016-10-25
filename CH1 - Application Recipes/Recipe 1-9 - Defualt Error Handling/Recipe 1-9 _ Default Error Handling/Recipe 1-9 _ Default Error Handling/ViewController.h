//
//  ViewController.h
//  Recipe 1-9  Default Error Handling
//
//  Created by joseph hoffman on 6/26/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorHandler.h"

@interface ViewController : UIViewController

- (IBAction)fakeNonFatalError:(id)sender;
- (IBAction)fakeFatalError:(id)sender;

@end
