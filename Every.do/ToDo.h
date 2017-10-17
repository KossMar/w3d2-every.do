//
//  ToDo.h
//  Every.do
//
//  Created by Mar Koss on 2017-10-17.
//  Copyright © 2017 Mar Koss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *toDoDescription;
@property (nonatomic) int priorityNumber;
@property (nonatomic) BOOL isCompleted;

- (instancetype)initWithName:(NSString*)name toDoDescription:(NSString*)description priorityNumber:(int)priority completionState:(BOOL)completed;

@end
