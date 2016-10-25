//
//  DetailedViewController.m
//  Recipe 7-3:Creating Custom Annotations
//
//  Created by joseph hoffman on 8/10/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@end

@implementation DetailedViewController

- (id)initWithAnnotation:(MyAnnotation *)annotation
{
    self = [super init];
    if (self) {
        self.annotation = annotation;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = self.annotation.title;
    self.subtitleLabel.text = self.annotation.subtitle;
    self.contactInformationLabel.text = self.annotation.contactInformation;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
