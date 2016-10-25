//
//  ViewController.m
//  Recipe 7-7: Starting Maps from Your App
//
//  Created by joseph hoffman on 8/11/13.
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

- (IBAction)startWithOnePlacemark:(id)sender {
    
    CLLocationCoordinate2D bigBenLocation = CLLocationCoordinate2DMake(51.50065200, -0.12483300);
    MKPlacemark *bigBenPlacemark = [[MKPlacemark alloc] initWithCoordinate:bigBenLocation addressDictionary:nil];
    MKMapItem *bigBenItem = [[MKMapItem alloc] initWithPlacemark:bigBenPlacemark];
    bigBenItem.name = @"Big Ben";
    
    [bigBenItem openInMapsWithLaunchOptions:nil];
}

- (IBAction)startWithMultiplePlacemarks:(id)sender {
    
    CLLocationCoordinate2D bigBenLocation = CLLocationCoordinate2DMake(51.50065200, -0.12483300);
    MKPlacemark *bigBenPlacemark = [[MKPlacemark alloc] initWithCoordinate:bigBenLocation addressDictionary:nil];
    MKMapItem *bigBenItem = [[MKMapItem alloc] initWithPlacemark:bigBenPlacemark];
    bigBenItem.name = @"Big Ben";
    
    CLLocationCoordinate2D westminsterLocation = CLLocationCoordinate2DMake(51.50054300, -0.13570200);
    MKPlacemark *westminsterPlacemark = [[MKPlacemark alloc] initWithCoordinate:westminsterLocation addressDictionary:nil];
    MKMapItem *westminsterItem = [[MKMapItem alloc] initWithPlacemark:westminsterPlacemark];
    westminsterItem.name = @"Westminster Abbey";
    
    NSArray *items = [[NSArray alloc] initWithObjects:bigBenItem, westminsterItem, nil];
    [MKMapItem openMapsWithItems:items launchOptions:nil];
}

- (IBAction)startInDirectionsMode:(id)sender {
    
    CLLocationCoordinate2D bigBenLocation =
    CLLocationCoordinate2DMake(51.50065200, -0.12483300);
    MKPlacemark *bigBenPlacemark = [[MKPlacemark alloc]
                                    initWithCoordinate:bigBenLocation addressDictionary:nil];
    MKMapItem *bigBenItem = [[MKMapItem alloc] initWithPlacemark:bigBenPlacemark];
    bigBenItem.name = @"Big Ben";
    
    CLLocationCoordinate2D westminsterLocation =
    CLLocationCoordinate2DMake(51.50054300, -0.13570200);
    MKPlacemark *westminsterPlacemark = [[MKPlacemark alloc]
                                         initWithCoordinate:westminsterLocation addressDictionary:nil];
    MKMapItem *westminsterItem = [[MKMapItem alloc]
                                  initWithPlacemark:westminsterPlacemark];
    westminsterItem.name = @"Westminster Abbey";
    
    NSArray *items = [[NSArray alloc] initWithObjects:bigBenItem, westminsterItem, nil];
    NSDictionary *options =
    @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking};
    [MKMapItem openMapsWithItems:items launchOptions:options];
}
@end
