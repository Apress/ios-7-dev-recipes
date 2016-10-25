//
//  ViewController.h
//  Recipe 2-3: Coding Autolayout
//
//  Created by joseph hoffman on 7/5/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UIButton *removeButton;
@property (strong, nonatomic) UIButton *clearButton;
@property (strong, nonatomic) NSMutableArray *imageViews;
@property (strong, nonatomic) NSMutableArray *imageViewConstraints;

@end
