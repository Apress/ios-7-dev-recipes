//
//  ViewController.m
//  Recipe 4-6 :Creating a flag picker collection view
//
//  Created by joseph hoffman on 7/13/13.
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

- (IBAction)pickFlag:(id)sender {
    UICollectionViewController *flagPicker =
    [[FlagPickerViewController alloc] initWithDelegate:self];
    
    [self presentViewController:flagPicker animated:YES completion:NULL];
}
-(void)flagPicker:(FlagPickerViewController *)flagPicker didPickFlag:(Flag *)flag
{
    self.flagImageView.image = flag.image;
    self.countryLabel.text = flag.name;
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
