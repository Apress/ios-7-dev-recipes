//
//  MainTableViewController.m
//  Recipe 8-4: Retrieving Tweets
//
//  Created by joseph hoffman on 8/14/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "MainTableViewController.h"
#import "TwitterFeedCell.h"
#import "TweetTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

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
    
    [self.tableView registerClass:TwitterFeedCell.class forCellReuseIdentifier:TwitterFeedCellId];
    
    self.navigationItem.title = @"My Twitter Reader";
    self.accountStore = [[ACAccountStore alloc] init];
    [self retrieveAccounts];
}

- (void)retrieveAccounts
{
    ACAccountType *accountType =
    [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [self.accountStore requestAccessToAccountsWithType:accountType options:nil
                                            completion:^(BOOL granted, NSError *error)
     {
         if (granted)
         {
             self.twitterAccounts = [self.accountStore accountsWithAccountType:accountType];
             dispatch_async(dispatch_get_main_queue(), ^(void)
                            {
                                [self.tableView reloadData];
                            });
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.twitterAccounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TwitterFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:TwitterFeedCellId forIndexPath:indexPath];
    // Configure the cell...

    cell.twitterAccount = [self.twitterAccounts objectAtIndex:indexPath.row];
  
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    ACAccount *account = nil;

        account = [self.twitterAccounts objectAtIndex:indexPath.row];
    
    TweetTableViewController *detailViewController = [[TweetTableViewController alloc] initWithTwitterAccount:account];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
