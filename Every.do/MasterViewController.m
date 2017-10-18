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
    
    UISwipeGestureRecognizer *swipeDone = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(markItemDone:)];
    [swipeDone setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.tableView addGestureRecognizer:swipeDone];
    
    
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


//
//    [self.objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

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
                                                    ToDo *newToDo = [[ToDo alloc]init];
                                                    newToDo.name = alert.textFields[0].text;
                                                    newToDo.priorityNumber = [alert.textFields[1].text intValue];
                                                    newToDo.toDoDescription = alert.textFields[2].text;
                                                    newToDo.isCompleted = NO;

                              [self.objects addObject:newToDo];
                              [self.tableView reloadData];
                          }]];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:nil];
        [alert addAction: cancel];
        [self presentViewController:alert animated:true completion:nil];
    }
    
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
    cell.showsReorderControl = YES;
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

- (void)markItemDone:(UISwipeGestureRecognizer*)sender {
    //Get location of the swipe
    CGPoint location = [sender locationInView:self.tableView];
    
    //Get the corresponding index path within the table view
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    //Check if index path is valid
    if(indexPath)
    {
        //Get the cell out of the table view
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        ToDo *object = self.objects[indexPath.row];
        
        NSMutableAttributedString *attributedNameString = [[NSMutableAttributedString alloc] initWithString:object.name];
        NSMutableAttributedString *attributedNameStrikeString = [[NSMutableAttributedString alloc] initWithString:object.name];
        [attributedNameStrikeString addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [attributedNameString length])];
        
        
        if (object.isCompleted == YES){
            object.isCompleted = NO;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.attributedText = attributedNameString;

        }
        else {
            object.isCompleted = YES;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.textLabel.attributedText = attributedNameStrikeString;
        }
        
    }
}

//-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
//    [super setEditing:<#editing#> animated:<#animated#>];
//    [self tableView:self.tableView canMoveRowAtIndexPath:];
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

@end
