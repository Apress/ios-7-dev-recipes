//
//  AppDelegate.h
//  Recipe 4-1 to 4-5: Creating UITableViews
//
//  Created by joseph hoffman on 7/11/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) MainTableViewController *tableViewController;

@end
