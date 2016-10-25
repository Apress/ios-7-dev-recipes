//
//  ViewController.m
//  Recipe 14-1: Working with NSCalendar and NSDate
//
//  Created by joseph hoffman on 8/30/13.
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
    self.gMonthTextField.delegate = self;
    self.gDayTextField.delegate = self;
    self.gYearTextField.delegate = self;
    self.hMonthTextField.delegate = self;
    self.hDayTextField.delegate = self;
    self.hYearTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy initialization methods

-(NSCalendar *)gregorianCalendar
{
    if (!_gregorianCalendar)
    {
        _gregorianCalendar =
        [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    }
    return _gregorianCalendar;
}

-(NSCalendar *)hebrewCalendar
{
    if (!_hebrewCalendar)
    {
        _hebrewCalendar =
        [[NSCalendar alloc] initWithCalendarIdentifier:NSHebrewCalendar];
    }
    return _hebrewCalendar;
}

#pragma mark - actions

- (IBAction)convertToHebrew:(id)sender
{
    NSDateComponents *gComponents = [[NSDateComponents alloc] init];
    [gComponents setDay:[self.gDayTextField.text integerValue]];
    [gComponents setMonth:[self.gMonthTextField.text integerValue]];
    [gComponents setYear:[self.gYearTextField.text integerValue]];
    
    NSDate *gregorianDate = [self.gregorianCalendar dateFromComponents:gComponents];
    
    NSUInteger unitFlags =
    NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    
    NSDateComponents *hebrewDateComponents =
    [self.hebrewCalendar components:unitFlags fromDate:gregorianDate];
    
    self.hDayTextField.text =
    [[NSNumber numberWithInteger:hebrewDateComponents.day] stringValue];
    self.hMonthTextField.text =
    [[NSNumber numberWithInteger:hebrewDateComponents.month] stringValue];
    self.hYearTextField.text =
    [[NSNumber numberWithInteger:hebrewDateComponents.year] stringValue];
    
}

- (IBAction)convertToGregorian:(id)sender
{
    NSDateComponents *hComponents = [[NSDateComponents alloc] init];
    [hComponents setDay:[self.hDayTextField.text integerValue]];
    [hComponents setMonth:[self.hMonthTextField.text integerValue]];
    [hComponents setYear:[self.hYearTextField.text integerValue]];
    
    NSDate *hebrewDate = [self.hebrewCalendar dateFromComponents:hComponents];
    
    NSUInteger unitFlags =
    NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    
    NSDateComponents *hebrewDateComponents =
    [self.gregorianCalendar components:unitFlags fromDate:hebrewDate];
    
    self.gDayTextField.text =
    [[NSNumber numberWithInteger:hebrewDateComponents.day] stringValue];
    self.gMonthTextField.text =
    [[NSNumber numberWithInteger:hebrewDateComponents.month] stringValue];
    self.gYearTextField.text =
    [[NSNumber numberWithInteger:hebrewDateComponents.year] stringValue];
}

#pragma mark - Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
@end
