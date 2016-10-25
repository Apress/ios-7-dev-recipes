//
//  ViewController.m
//  Recipe 3-3: Debugging Autolayout
//
//  Created by joseph hoffman on 7/5/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 setTitle:@"Button 1" forState:UIControlStateNormal];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setTitle:@"Button 2" forState:UIControlStateNormal];
    button2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 setTitle:@"Button 3" forState:UIControlStateNormal];
    button3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button3];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(button1, button2, button3);
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[button1]" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[button2]" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[button3]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"[button1(<=100)]-[button2(==button1)]-[button3(==button1)]"
                               options:0 metrics:nil views:viewsDictionary]];
    
    NSLayoutConstraint *pinToLeft = [NSLayoutConstraint
                                     constraintWithItem:button1 attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:self.view attribute:NSLayoutAttributeLeading
                                     multiplier:1 constant:20];
    pinToLeft.priority = 500;
    [self.view addConstraint:pinToLeft];
    
    NSLayoutConstraint *pinToRight = [NSLayoutConstraint
                                      constraintWithItem:button3 attribute:NSLayoutAttributeTrailing
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self.view attribute:NSLayoutAttributeTrailing
                                      multiplier:1 constant:20];
    pinToRight.priority = 500;
    [self.view addConstraint:pinToRight];
    
    NSLayoutConstraint *center = [NSLayoutConstraint
                                  constraintWithItem:button2 attribute:NSLayoutAttributeCenterX 
                                  relatedBy:NSLayoutRelationEqual 
                                  toItem:self.view attribute:NSLayoutAttributeCenterX 
                                  multiplier:1 constant:0];
    [self.view addConstraint:center];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
