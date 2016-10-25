//
//  TweetViewController.m
//  Recipe 8-4: Retrieving Tweets
//
//  Created by joseph hoffman on 8/15/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

-(id)initWithTweetData:(NSDictionary *)tweetData
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _tweetData = tweetData;
    }
    return self;
}

-(void)setTweetData:(NSDictionary *)tweetData
{
    _tweetData = tweetData;
    [self updateView];
}

-(void)updateView
{
    NSDictionary *userData = [self.tweetData objectForKey:@"user"];
    
    NSLog(@"Data For User: %@", userData);
    
    NSString *imageURLString = [userData objectForKey:@"profile_image_url"];
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    self.userImageView.image = [UIImage imageWithData:imageData];
    
    self.userNameLabel.text = [userData objectForKey:@"name"];
    self.userScreenNameLabel.text = [userData objectForKey:@"screen_name"];
    self.userDescriptionLabel.text = [userData objectForKey:@"description"];
    
    self.tweetTextView.text = [self.tweetData objectForKey:@"text"];
    self.retweetCountLabel.text = [NSString stringWithFormat:@"Retweet Count: %@", [self.tweetData objectForKey:@"retweet_count"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Tweet";
    [self updateView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
