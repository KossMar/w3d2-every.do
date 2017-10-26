//
//  MasterViewController.m
//  Every.do
//
//  Created by Mar Koss on 2017-10-17.
//  Copyright © 2017 Mar Koss. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
//#import "ToDo.h"

@interface MasterViewController () 

@property NSMutableArray *objects;
//@property ToDo *toDo1;
//@property ToDo *toDo2;
//@property ToDo *toDo3;

@end

@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    

//    self.toDo1 = [[ToDo alloc] initWithName:@"Walk dog" toDoDescription:@"Gotta walk that bitch erryday you know what it do" priorityNumber:3 completionState:YES];
//    self.toDo2 = [[ToDo alloc] initWithName:@"Eat Food" toDoDescription:@"I need this to live. Prioritize eating food and then work on eating better food" priorityNumber:1 completionState:NO];
//    self.toDo3 = [[ToDo alloc] initWithName:@"Make it in the big leagues" toDoDescription:@"I'm gonna make it, papa! I don't care what papa says. I have conflicting ideas of Papa that exist in my head simultaneously" priorityNumber:2 completionState:NO];

    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
//    UISwipeGestureRecognizer *swipeDone = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(markItemDone:)];
//    [swipeDone setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self.tableView addGestureRecognizer:swipeDone];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];

    {
        
        UIAlertController* alert;
        alert = [UIAlertController alertControllerWithTitle:@"Add"
                                                   message:@"Enter new item"
                                            preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"name";
            textField.font = [UIFont systemFontOfSize:22];
            textField.textAlignment = NSTextAlignmentCenter;
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"priority";
            textField.font = [UIFont systemFontOfSize:22];
            textField.textAlignment = NSTextAlignmentCenter;
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"description";
            textField.font = [UIFont systemFontOfSize:22];
            textField.textAlignment = NSTextAlignmentCenter;
        }];
        
        
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
                                                    ToDo *newToDo = [[ToDo alloc] initWithContext:context];
                                                    newToDo.name = alert.textFields[0].text;
                                                    newToDo.priorityNumber = [alert.textFields[1].text intValue];
                                                    newToDo.toDoDescription = alert.textFields[2].text;
                                                    newToDo.isCompleted = NO;


                              [self.tableView reloadData];
                          }]];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
        [alert addAction: cancel];
        [self presentViewController:alert animated:true completion:nil];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:object];

    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //       *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    ToDo *todo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withToDo:todo];
    return cell;
}


- (void)configureCell:(UITableViewCell *)cell withToDo:(ToDo *)todo {
    cell.textLabel.text = todo.name;
    cell.detailTextLabel.text = todo.toDoDescription;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

//- (void)markItemDone:(UISwipeGestureRecognizer*)sender {
//    //Get location of the swipe
//    CGPoint location = [sender locationInView:self.tableView];
//    
//    //Get the corresponding index path within the table view
//    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
//    
//    //Check if index path is valid
//    if(indexPath)
//    {
//        //Get the cell out of the table view
//        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//        
//        ToDo *newToDo = [[ToDo alloc] initWithContext:context];
//
//        NSMutableAttributedString *attributedNameString = [[NSMutableAttributedString alloc] initWithString:object.name];
//        NSMutableAttributedString *attributedNameStrikeString = [[NSMutableAttributedString alloc] initWithString:object.name];
//        [attributedNameStrikeString addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [attributedNameString length])];
//        
//        
//        if (object.isCompleted == YES){
//            object.isCompleted = NO;
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.textLabel.attributedText = attributedNameString;
//
//        }
//        else {
//            object.isCompleted = YES;
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            cell.textLabel.attributedText = attributedNameStrikeString;
//        }
//        
//    }
//}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    ToDo *objectToMove = [self.objects objectAtIndex:sourceIndexPath.row];
    [self.objects removeObjectAtIndex:sourceIndexPath.row];
    [self.objects insertObject:objectToMove atIndex:destinationIndexPath.row];
    [tableView reloadData];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}



#pragma mark - Fetched results controller

- (NSFetchedResultsController<ToDo *> *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<ToDo *> *fetchRequest = ToDo.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES  selector:@selector(localizedCaseInsensitiveCompare:)];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<ToDo *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withToDo:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withToDo:anObject];
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
