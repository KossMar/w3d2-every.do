//
//  DetailViewController.m
//  Every.do
//
//  Created by Mar Koss on 2017-10-17.
//  Copyright © 2017 Mar Koss. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setToDoObject:(ToDo *)toDoObject {
    if (_toDoObject != toDoObject) {
        _toDoObject = toDoObject;
            
        // Update the view.
        [self configureView];
    }
}


- (void)configureView {
    _nameLabel.text = self.toDoObject.name;
    _priorityLabel.text = [NSString stringWithFormat:@"%i", self.toDoObject.priorityNumber];
    _descriptionLabel.text = self.toDoObject.toDoDescription;
    _completedLabel.text = [NSString stringWithFormat:@"%@", self.toDoObject.isCompleted ? @"YES" : @"NO"];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureView];


}





@end
