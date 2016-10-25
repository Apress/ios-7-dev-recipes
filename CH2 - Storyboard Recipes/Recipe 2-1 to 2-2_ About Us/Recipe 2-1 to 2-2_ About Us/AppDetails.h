//
//  AppDetails.h
//  Recipe 2-1 to 2-2 About Us
//
//  Created by joseph hoffman on 6/30/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDetails : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *description;

-(id)initWithName:(NSString *)name description:(NSString *)descr;

@end
