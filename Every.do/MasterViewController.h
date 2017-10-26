//
//  MasterViewController.h
//  Every.do
//
//  Created by Mar Koss on 2017-10-17.
//  Copyright © 2017 Mar Koss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Every.do-add-coredata+CoreDataModel.h"
//#import "ToDo.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController<ToDo *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;




@end

