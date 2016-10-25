//
//  VocabulariesViewController.h
//  Recipe 15-3 Using Core Data
//
//  Created by joseph hoffman on 9/3/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vocabulary.h"
#import "WordsviewController.h"

@interface VocabulariesViewController : UITableViewController <UIAlertViewDelegate>

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
