//
//  TweetCell.h
//  Recipe 8-4: Retrieving Tweets
//
//  Created by joseph hoffman on 8/15/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const TweetCellId;

@interface TweetCell : UITableViewCell

@property (strong, nonatomic)NSDictionary *tweetData;

@end