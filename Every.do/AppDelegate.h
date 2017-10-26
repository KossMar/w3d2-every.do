//
//  AppDelegate.h
//  Every.do
//
//  Created by Mar Koss on 2017-10-17.
//  Copyright © 2017 Mar Koss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, readonly) NSManagedObjectContext       *context;
@property (nonatomic, readonly) NSManagedObjectModel         *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly) NSPersistentStore            *store;
@property (readonly, strong) NSPersistentContainer *persistentContainer;


//- (void)setupCoreData;
- (void)saveContext;



@end

