//
//  DetailViewController.h
//  Every.do
//
//  Created by Mar Koss on 2017-10-17.
//  Copyright © 2017 Mar Koss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Every.do-add-coredata+CoreDataModel.h"


@interface DetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIDatePicker *setDeadLine;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedLabel;
@property (strong, nonatomic) ToDo *detailItem;


@end

