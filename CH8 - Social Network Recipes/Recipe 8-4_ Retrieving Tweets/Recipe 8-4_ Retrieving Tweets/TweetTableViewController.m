//
//  RecentTweetsTableViewController.m
//  Recipe 8-4: Retrieving Tweets
//
//  Created by joseph hoffman on 8/15/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "TweetTableViewController.h"
#import "TweetViewController.h"
#import "TweetCell.h"

@interface TweetTableViewController ()

@end

@implementation TweetTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tweets = [[NSMutableArray alloc] initWithCapacity:50];
    }
    return self;
}

-(id)initWithTwitterAccount:(ACAccount *)account
{
    self = [self initWithStyle:UITableViewStylePlain];
    if (self) {
        self.twitterAccount = account;
    }
    return self;
}

-(void)retrieveTweets
{
    [self.tweets removeAllObjects];
    
    SLRequest *request;
    
    if (self.twitterAccount)
    {
        NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"];
        request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:nil];
        [request setAccount:self.twitterAccount];
    }
    else
    {
        NSURL *requestURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/public_timeline.json"];
        request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:nil];
    }
    
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
     {
         if ([urlResponse statusCode] == 200)
         {
             NSError *jsonParsingError;
             self.tweets = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonParsingError];
         }
         else
         {
             NSLog(@"HTTP response status: %i\n", [urlResponse statusCode]);
         }
         dispatch_async(dispatch_get_main_queue(), ^(void)
                        {
                            [self.tableView reloadData];
                        });
     }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:TweetCell.class forCellReuseIdentifier:TweetCellId];
    
    if (self.twitterAccount)
    {
        self.navigationItem.title = self.twitterAccount.accountDescription;
    }
    else
    {
        self.navigationItem.title = @"Public Tweets";
    }
    [self retrieveTweets];
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
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:TweetCellId forIndexPath:indexPath];
    // Configure the cell...
    cell.tweetData = [self.tweets objectAtIndex:indexPath.row];
    
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
    NSDictionary *tweetData = [self.tweets objectAtIndex:indexPath.row];
    TweetViewController *detailViewController = [[TweetViewController alloc] initWithTweetData:tweetData];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
