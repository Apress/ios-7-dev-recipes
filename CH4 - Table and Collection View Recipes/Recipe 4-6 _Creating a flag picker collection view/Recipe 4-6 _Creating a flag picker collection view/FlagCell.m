//
//  FlagCell.m
//  Recipe 4-6 :Creating a flag picker collection view
//
//  Created by joseph hoffman on 7/13/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "FlagCell.h"

@implementation FlagCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.nameLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(0, 56, 100, 19)];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.nameLabel];
        
        self.flagImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 88, 49)];
        [self.contentView addSubview:self.flagImageView];
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:frame];
        self.selectedBackgroundView.backgroundColor = [UIColor grayColor];
    }
    return self;
}

@end
