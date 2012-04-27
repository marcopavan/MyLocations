//
//  CategoryPickerViewController.m
//  MyLocations
//
//  Created by Marco Pavan on 27/04/12.
//  Copyright (c) 2012 mpsoftware. All rights reserved.
//

#import "CategoryPickerViewController.h"

@interface CategoryPickerViewController ()

@end

@implementation CategoryPickerViewController {
    NSArray *categories;
    NSIndexPath *selectedIndexPath;
}

@synthesize selectedCategoryName, delegate;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        categories = [NSArray arrayWithObjects:
                      @"No Category",
                      @"Apple Store",
                      @"Bar",
                      @"Bookstore",
                      @"Club",
                      @"Grocery Store",
                      @"Historic Building",
                      @"House",
                      @"IceCream Vendor",
                      @"Landmark",
                      @"Park",
                      nil];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    categories = nil;
    selectedIndexPath = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    
    NSString *categoryName = [categories objectAtIndex:indexPath.row];
    label.text = categoryName;
    
    if ([categoryName isEqualToString:selectedCategoryName]) {
        selectedIndexPath = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != selectedIndexPath.row) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:selectedIndexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        selectedIndexPath = indexPath;
    }
    NSString *categoryName = [categories objectAtIndex:indexPath.row];
    [self.delegate categoryPicker:self didPickCategory:categoryName];
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
