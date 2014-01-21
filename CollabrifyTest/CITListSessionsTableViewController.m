//
//  CITListSessionsTableViewController.m
//  CollabrifyTest
//
//  Created by Brandon Knope on 11/26/13.
//  Copyright (c) 2013 Collabrify.it. All rights reserved.
//

#import "CITListSessionsTableViewController.h"
#import <Collabrify/Collabrify.h>

@interface CITListSessionsTableViewController ()

@property (strong, nonatomic) NSArray *sessions;

@end

@implementation CITListSessionsTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [[self client] listSessionsWithTags:[self tags] completionHandler:^(NSArray *sessions, CollabrifyError *error) {
        if (error) NSLog(@"Error = %@", error);
        
        [self setSessions:sessions];
        [[self tableView] reloadData];
    }];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self sessions] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SessionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    CollabrifySession *session = [[self sessions] objectAtIndex:indexPath.row];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [[cell textLabel] setText:[session sessionName]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollabrifySession *session = [[self sessions] objectAtIndex:indexPath.row];
    
    [[self delegate] listSessionsTVC:self selectedSession:session];
}

@end
