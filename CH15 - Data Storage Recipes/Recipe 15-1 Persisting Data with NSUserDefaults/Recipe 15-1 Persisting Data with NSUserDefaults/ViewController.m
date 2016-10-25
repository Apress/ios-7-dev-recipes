//
//  ViewController.m
//  Recipe 15-1 Persisting Data with NSUserDefaults
//
//  Created by joseph hoffman on 9/3/13.
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
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    
    [self loadPersistentData:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(savePersistentData:)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleActivity:(id)sender
{
    if (self.activitySwitch.on)
    {
        [self.activityIndicator startAnimating];
    }
    else
    {
        [self.activityIndicator stopAnimating];
    }
}
#pragma mark - helper methods

- (void)savePersistentData:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //Set Objects/Values to Persist
    [userDefaults setObject:self.firstNameTextField.text forKey:@"firstName"];
    [userDefaults setObject:self.lastNameTextField.text forKey:@"lastName"];
    [userDefaults setBool:self.activitySwitch.on forKey:@"activityOn"];
    
    //Save Changes
    [userDefaults synchronize];
}

- (void)loadPersistentData:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.firstNameTextField.text = [userDefaults objectForKey:@"firstName"];
    self.lastNameTextField.text = [userDefaults objectForKey:@"lastName"];
    [self.activitySwitch setOn:[userDefaults boolForKey:@"activityOn"] animated:NO];
    
    if (self.activitySwitch.on)
    {
        [self.activityIndicator startAnimating];
    }
}


#pragma mark - delegate methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
@end
