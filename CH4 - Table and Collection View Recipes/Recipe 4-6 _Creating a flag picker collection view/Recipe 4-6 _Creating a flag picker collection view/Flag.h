//
//  Flag.h
//  Recipe 4-6 :Creating a flag picker collection view
//
//  Created by joseph hoffman on 7/13/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flag : NSObject

@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)UIImage *image;

- (id)initWithName:(NSString *)name imageName:(NSString *)imageName;

@end
