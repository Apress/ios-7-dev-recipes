//
//  ViewController.m
//  My SIngle View App
//
//  Created by joseph hoffman on 6/20/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.myButton setTitle:@"Outlet!" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Testing Actions"
                                                    message:@"Hello Brother!"
                                                   delegate:nil
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:nil];
    [alert show];
    
}

- (IBAction)sayHello:(id)sender {
}
@end
