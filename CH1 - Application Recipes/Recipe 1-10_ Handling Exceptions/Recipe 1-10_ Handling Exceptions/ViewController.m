//
//  ViewController.m
//  Recipe 1-10 Handling Exceptions
//
//  Created by joseph hoffman on 6/26/13.
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)throwFakeException:(id)sender
{
    NSException *e = [[NSException alloc] initWithName:@"FakeException"
                                                reason:@"The developer sucks!"
                                              userInfo:[NSDictionary dictionaryWithObject:@"Extra info"
                                                                                   forKey:@"Key"]];
    [e raise];
}
@end
