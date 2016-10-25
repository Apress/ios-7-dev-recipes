//
//  Flag.m
//  Recipe 4-6 :Creating a flag picker collection view
//
//  Created by joseph hoffman on 7/13/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "Flag.h"

@implementation Flag

- (id)initWithName:(NSString *)name imageName:(NSString *)imageName
{
    self = [super init];
    if (self) {
        self.name = name;
        NSString *imageFile = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
        self.image = [[UIImage alloc] initWithContentsOfFile:imageFile];
    }
    return self;
}

@end
