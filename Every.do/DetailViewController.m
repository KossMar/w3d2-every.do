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

//- (void)setToDoObject:(ToDo *)toDoObject {
//    if (_toDoObject != toDoObject) {
//        _toDoObject = toDoObject;
//
//        // Update the view.
//        [self configureView];
//    }
//}


- (void)configureView {
    if (self.detailItem) {
        self.descriptionLabel.text = self.detailItem.name;
        
        self.nameLabel.text = self.detailItem.name;
        self.priorityLabel.text = [NSString stringWithFormat:@"%i", self.detailItem.priorityNumber];
        self.descriptionLabel.text = self.detailItem.toDoDescription;
        self.completedLabel.text = [NSString stringWithFormat:@"%@", self.detailItem.isCompleted ? @"YES" : @"NO"];
//        self.setDeadLine.date = self.detailItem.deadline;
        
    }
}
- (IBAction)deadlineAction:(UIDatePicker *)sender {
//    self.toDoObject.deadline = sender.date;
//        NSLog(@"%@",self.toDoObject.deadline);

}


- (void)viewDidLoad {
    [super viewDidLoad];


    [self.setDeadLine setMinimumDate:[NSDate date]];
    
    [self configureView];


}


    





@end
