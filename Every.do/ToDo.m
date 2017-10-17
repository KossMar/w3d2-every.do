//
//  ToDo.m
//  Every.do
//
//  Created by Mar Koss on 2017-10-17.
//  Copyright © 2017 Mar Koss. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithName:(NSString*)name toDoDescription:(NSString*)description priorityNumber:(int)priority completionState:(BOOL)completed {
    
    self = [super init];
    if (self) {
        _name = name;
        _toDoDescription = description;
        _priorityNumber = priority;
        _isCompleted = completed;
    }
    return self;
}


@end
