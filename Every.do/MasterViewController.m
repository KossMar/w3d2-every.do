//
//  MasterViewController.m
//  Every.do
//
//  Created by Mar Koss on 2017-10-17.
//  Copyright © 2017 Mar Koss. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ToDo.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@property ToDo *toDo1;
@property ToDo *toDo2;
@property ToDo *toDo3;

@end

@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    self.toDo1 = [[ToDo alloc] initWithName:@"Walk dog" toDoDescription:@"Gotta walk that bitch erryday you know what it do" priorityNumber:3 completionState:YES];
    self.toDo2 = [[ToDo alloc] initWithName:@"Eat Food" toDoDescription:@"I need this to live. Prioritize eating food and then work on eating better food" priorityNumber:1 completionState:NO];
    self.toDo3 = [[ToDo alloc] initWithName:@"Make it in the big leagues" toDoDescription:@"I'm gonna make it, papa! I don't care what papa says. I have conflicting ideas of Papa that exist in my head simultaneously" priorityNumber:2 completionState:NO];

    self.objects = [[NSMutableArray alloc] initWithObjects:self.toDo1, self.toDo2, self.toDo3, nil];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}


- (void)viewWillAppear:(BOOL)animated {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setToDoObject:object];
//        controller.nameLabel.text = object.name;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    ToDo *object = self.objects[indexPath.row];
    cell.textLabel.text = [object.name stringByAppendingString:[NSString stringWithFormat:@" (%i)", object.priorityNumber]];
    cell.detailTextLabel.text = object.toDoDescription;
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}



@end
