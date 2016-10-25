//
//  AppDetailsViewController.m
//  Recipe 2-1 to 2-2 About Us
//
//  Created by joseph hoffman on 6/30/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "AppDetailsViewController.h"

@interface AppDetailsViewController ()

@end

@implementation AppDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.nameLabel.text = self.appDetails.name;
    self.descriptionTextView.text = self.appDetails.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
