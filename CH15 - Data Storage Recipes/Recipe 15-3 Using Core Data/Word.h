//
//  Word.h
//  Recipe 15-3 Using Core Data
//
//  Created by joseph hoffman on 9/3/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Vocabulary;

@interface Word : NSManagedObject

@property (nonatomic, retain) NSString * word;
@property (nonatomic, retain) NSString * translation;
@property (nonatomic, retain) Vocabulary *vocabulary;

@end
