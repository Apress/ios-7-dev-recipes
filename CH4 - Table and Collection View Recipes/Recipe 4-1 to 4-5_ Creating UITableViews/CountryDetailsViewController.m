//
//  CountryDetailsViewsControllerViewController.m
//  Recipe 4-1 to 4-5: Creating UITableViews
//
//  Created by joseph hoffman on 7/11/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "CountryDetailsViewController.h"

@interface CountryDetailsViewController ()

@end

@implementation CountryDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self populateViewWithCountry:self.currentCountry];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mottoTextField.delegate = self;
    self.capitalTextField.delegate = self;
    
    UIBarButtonItem *revertButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Revert"
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(revert)];
    
    self.navigationItem.rightBarButtonItems =
    [NSArray arrayWithObject:revertButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)populateViewWithCountry:(Country *)country
{
    self.currentCountry = country;
    
    self.flagImageView.image = country.flag;
    self.nameLabel.text = country.name;
    self.capitalTextField.text = country.capital;
    self.mottoTextField.text = country.motto;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
-(void)revert
{
    [self populateViewWithCountry:self.currentCountry];
}

-(void)viewWillDisappear:(BOOL)animated
{
    // End any editing that may be in progress at this point
    [self.view.window endEditing: YES];
    
    // Update the country object with the new values
    self.currentCountry.capital = self.capitalTextField.text;
    self.currentCountry.motto = self.mottoTextField.text;
    [self.delegate countryDetailsViewControllerDidFinish:self];
}


@end
