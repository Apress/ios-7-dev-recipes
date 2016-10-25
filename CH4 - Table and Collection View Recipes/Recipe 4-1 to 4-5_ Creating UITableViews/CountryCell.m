//
//  CountryCell.m
//  Recipe 4-1 to 4-5: Creating UITableViews
//
//  Created by joseph hoffman on 7/13/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "CountryCell.h"

@implementation CountryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        self.textLabel.font = [UIFont systemFontOfSize:19.0];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)setCountry:(Country *)country
{
    if (country != _country)
    {
        _country = country;
        self.textLabel.text = _country.name;
        self.detailTextLabel.text = _country.capital;
        self.imageView.image =
        [CountryCell scale: _country.flag toSize:CGSizeMake(115, 75)];
    }
}

@end
