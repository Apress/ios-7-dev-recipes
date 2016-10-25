//
//  TwitterFeedCell.m
//  Recipe 8-4: Retrieving Tweets
//
//  Created by joseph hoffman on 8/14/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "TwitterFeedCell.h"

NSString * const TwitterFeedCellId = @"TwitterFeedCell";

@implementation TwitterFeedCell

- (void)setTwitterAccount:(ACAccount *)account
{
    _twitterAccount = account;
    if (_twitterAccount)
    {
        self.textLabel.text = _twitterAccount.accountDescription;
    }
    else
    {
        NSLog(@"No Twitter Account Given!");
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
