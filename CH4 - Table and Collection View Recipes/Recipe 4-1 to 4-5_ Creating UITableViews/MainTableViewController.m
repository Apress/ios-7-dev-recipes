//
//  MainTableViewController.m
//  Recipe 4-1 to 4-5: Creating UITableViews
//
//  Created by joseph hoffman on 7/11/13.
//  Copyright (c) 2013 NSCookbook. All rights reserved.
//

#import "MainTableViewController.h"
#import "CountryCell.h"

@interface MainTableViewController ()


@end

@implementation MainTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Countries";
    self.countriesTableView.delegate = self;
    self.countriesTableView.dataSource = self;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.countriesTableView registerClass:CountryCell.class
                    forCellReuseIdentifier:@"CountryCell"];

    
    self.countriesTableView.delegate = self;
    self.countriesTableView.dataSource = self;

    self.title = @"Countries";
    Country *usa = [[Country alloc] init];
    usa.name = @"United States of America";
    usa.motto = @"E Pluribus Unum";
    usa.capital = @"Washington, D.C.";
    usa.flag = [UIImage imageNamed:@"usa.png"];
    
    Country *france = [[Country alloc] init];
    france.name = @"French Republic";
    france.motto = @"Liberté, Égalité, Fraternité";
    france.capital = @"Paris";
    france.flag = [UIImage imageNamed:@"france.png"];
    
    Country *england = [[Country alloc] init];
    england.name = @"England";
    england.motto = @"Dieu et mon droit";
    england.capital = @"London";
    england.flag = [UIImage imageNamed:@"england.png"];
    
    Country *scotland = [[Country alloc] init];
    scotland.name = @"Scotland";
    scotland.motto = @"In My Defens God Me Defend";
    scotland.capital = @"Edinburgh";
    scotland.flag = [UIImage imageNamed:@"scotland.png"];
    
    Country *spain = [[Country alloc] init];
    spain.name = @"Kingdom of Spain";
    spain.motto = @"Plus Ultra";
    spain.capital = @"Madrid";
    spain.flag = [UIImage imageNamed:@"spain.png"];
    
    self.unitedKingdomCountries = [NSMutableArray arrayWithObjects:england, scotland, nil];
    self.nonUKCountries = [NSMutableArray arrayWithObjects:usa, france, spain, nil];
    self.countries = [NSMutableArray arrayWithObjects:self.unitedKingdomCountries, self.nonUKCountries, nil];
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - overrides 

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.countriesTableView setEditing:editing animated:animated];
}

#pragma mark - Data Source Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *group = [self.countries objectAtIndex:section];
    return [group count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.countries count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"United Kingdom Countries";
    }
    return @"Non-United Kingdom Countries";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CountryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCell"];
    NSArray *group = [self.countries objectAtIndex:indexPath.section];
    cell.country = [group objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSMutableArray *group = [self.countries objectAtIndex:indexPath.section];
        Country *deletedCountry = [group objectAtIndex:indexPath.row];
        [group removeObject:deletedCountry];
        
        [self.countriesTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        NSMutableArray *group = [self.countries objectAtIndex:indexPath.section];
        Country *copiedCountry = [group objectAtIndex:indexPath.row];
        Country *newCountry = [[Country alloc] init];
        newCountry.name = copiedCountry.name;
        newCountry.flag = copiedCountry.flag;
        newCountry.capital = copiedCountry.capital;
        newCountry.motto = copiedCountry.motto;
        
        [group insertObject:newCountry atIndex:indexPath.row+1];
        
        [self.countriesTableView insertRowsAtIndexPaths:
         [NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row+1
                                                     inSection:indexPath.section]]
                                       withRowAnimation:UITableViewRowAnimationRight];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:
(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //Assume same Section
    NSMutableArray *group = [self.countries objectAtIndex:sourceIndexPath.section];
    if (destinationIndexPath.row < [group count])
    {
        [group exchangeObjectAtIndex:sourceIndexPath.row
                   withObjectAtIndex:destinationIndexPath.row];
    }
    [self.countriesTableView reloadData];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0)
        return @"United Kingdom Countries";
    return @"Non-United Kingdom Countries";
}


#pragma mark - delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedIndexPath = indexPath;
    
    NSArray *group = [self.countries objectAtIndex:indexPath.section];
    Country *chosenCountry = [group objectAtIndex:indexPath.row];
    CountryDetailsViewController *detailedViewController =
    [[CountryDetailsViewController alloc] init];
    detailedViewController.delegate = self;
    detailedViewController.currentCountry = chosenCountry;
    
    [self.navigationController pushViewController:detailedViewController animated:YES];
}
-(void)countryDetailsViewControllerDidFinish:(CountryDetailsViewController *)sender
{
    if (selectedIndexPath)
    {
        [self.countriesTableView beginUpdates];
        [self.countriesTableView reloadRowsAtIndexPaths:
         [NSArray arrayWithObject:selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.countriesTableView endUpdates];
    }
    selectedIndexPath = nil;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedIndexPath = indexPath;
    
    NSArray *group = [self.countries objectAtIndex:indexPath.section];
    Country *chosenCountry = [group objectAtIndex:indexPath.row];
    CountryDetailsViewController *detailedViewController =
    [[CountryDetailsViewController alloc] init];
    detailedViewController.delegate = self;
    detailedViewController.currentCountry = chosenCountry;
    
    NSLog(@"Accessory Button Tapped");
    [self.navigationController pushViewController:detailedViewController animated:YES];
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row % 2) == 1)
    {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}












@end
