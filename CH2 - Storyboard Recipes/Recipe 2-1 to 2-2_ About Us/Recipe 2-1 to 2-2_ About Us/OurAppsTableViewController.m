//
//  OurAppsTableViewController.m
//  Recipe 2-1 to 2-2 About Us
//
//  Created by joseph hoffman on 7/1/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "OurAppsTableViewController.h"
#import "AppDetailsViewController.h"
#import "AppDetails.h"

@interface OurAppsTableViewController ()

@end

@implementation OurAppsTableViewController



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PushAppDetails"])
    {
        AppDetailsViewController *appDetailsViewController = segue.destinationViewController;
        UITableViewCell *cell = sender;
        appDetailsViewController.appDetails =
        [[AppDetails alloc] initWithName:cell.textLabel.text
                             description:cell.detailTextLabel.text];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Set the CellIdentifier that you set in the storyboard
    static NSString *CellIdentifier = @"AppCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Awesome App";
            cell.detailTextLabel.text = @"Long description of the awesome app...";
            break;
        case 1:
            cell.textLabel.text = @"Even More Awesome App";
            cell.detailTextLabel.text = @"Long description of the even more awesome app...";
            break;
        case 2:
            cell.textLabel.text = @"The Most Awesome App Ever";
            cell.detailTextLabel.text =
            @"Long description of the most awesome app ever seen...";
            break;
            
        default:
            cell.textLabel.text = @"Unkown";
            cell.detailTextLabel.text = @"Unknown";
            break;
    }
    
    return cell;
}


@end
