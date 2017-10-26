//
//  CoreDataHelper.h
//  Every.do add coredata
//
//  Created by Mar Koss on 2017-10-25.
//  Copyright © 2017 Mar Koss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

@property (nonatomic, readonly) NSManagedObjectContext       *context;
@property (nonatomic, readonly) NSManagedObjectModel         *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly) NSPersistentStore            *store;

- (void)setupCoreData;
- (void)saveContext;

@end
