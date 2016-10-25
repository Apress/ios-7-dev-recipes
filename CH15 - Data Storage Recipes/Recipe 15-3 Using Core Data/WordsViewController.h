//
//  WordsViewController.h
//  Recipe 15-3 Using Core Data
//
//  Created by joseph hoffman on 9/3/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vocabulary.h"
#import "word.h"
#import "EditWordViewController.h"

@interface WordsViewController : UITableViewController

@property (strong, nonatomic) Vocabulary *vocabulary;

-(id)initWithVocabulary:(Vocabulary *)vocabulary;

@end
