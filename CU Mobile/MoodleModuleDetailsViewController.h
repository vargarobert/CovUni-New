//
//  MoodleModuleDetailsViewController.h
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuStudentViewController.h"



@interface MoodleModuleDetailsViewController : UITableViewController

@property (nonatomic, strong) NSString *moduleId;
@property (nonatomic, strong) NSMutableArray *moduleFiles;

@end
