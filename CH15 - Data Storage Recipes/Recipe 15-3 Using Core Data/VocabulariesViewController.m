//
//  VocabulariesViewController.m
//  Recipe 15-3 Using Core Data
//
//  Created by joseph hoffman on 9/3/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "VocabulariesViewController.h"

@interface VocabulariesViewController ()

@end

@implementation VocabulariesViewController

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.managedObjectContext = context;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Vocabularies";
    
    UIBarButtonItem *addButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addButton;

    
    [self fetchVocabularies];
    
    // Preload with a “Spanish” Vocabulary if empty
    if (self.fetchedResultsController.fetchedObjects.count == 0)
    {
        NSEntityDescription *vocabularyEntityDescription =
        [NSEntityDescription entityForName:@"Vocabulary"
                    inManagedObjectContext:self.managedObjectContext];
        Vocabulary *spanishVocabulary = (Vocabulary *)[[NSManagedObject alloc]
                                                       initWithEntity:vocabularyEntityDescription
                                                       insertIntoManagedObjectContext:self.managedObjectContext];
        spanishVocabulary.name = @"Spanish";
        NSError *error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Error saving context: %@", error);
        }
        [self fetchVocabularies];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self fetchVocabularies];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"VocabularyCell";
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Vocabulary *vocabulary = (Vocabulary *)[self.fetchedResultsController
                                            objectAtIndexPath:indexPath];
    cell.textLabel.text = vocabulary.name;
    cell.detailTextLabel.text =
    [NSString stringWithFormat:@"(%d)", vocabulary.words.count];
    
    return cell;
}



- (void)add
{
    UIAlertView * inputAlert = [[UIAlertView alloc] initWithTitle:@"New Vocabulary"
                                                          message:@"Enter a name for the new vocabulary" delegate:self
                                                cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    inputAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [inputAlert show];
}

#pragma mark - helper methods

-(void)fetchVocabularies
{
    NSFetchRequest *fetchRequest =
    [NSFetchRequest fetchRequestWithEntityName:@"Vocabulary"];
    NSString *cacheName = [@"Vocabulary" stringByAppendingString:@"Cache"];
    
    NSSortDescriptor *sortDescriptor =
    [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext
                                     sectionNameKeyPath:nil cacheName:cacheName];
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error])
    {
        NSLog(@"Fetch failed: %@", error);
    }
}

# pragma mark - delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSEntityDescription *vocabularyEntityDescription =
        [NSEntityDescription entityForName:@"Vocabulary"
                    inManagedObjectContext:self.managedObjectContext];
        Vocabulary *newVocabulary = (Vocabulary *)[[NSManagedObject alloc]
                                                   initWithEntity:vocabularyEntityDescription
                                                   insertIntoManagedObjectContext:self.managedObjectContext];
        newVocabulary.name = [alertView textFieldAtIndex:0].text;
        NSError *error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Error saving context: %@", error);
        }
        [self fetchVocabularies];
        [self.tableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObject *deleted =
        [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:deleted];
        NSError *error;
        BOOL success = [self.managedObjectContext save:&error];
        if (!success)
        {
            NSLog(@"Error saving context: %@", error);
        }
        [self fetchVocabularies];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationRight];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Vocabulary *vocabulary = (Vocabulary *)[self.fetchedResultsController
                                            objectAtIndexPath:indexPath];
    
    WordsViewController *detailViewController =
    [[WordsViewController alloc] initWithVocabulary:vocabulary];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
