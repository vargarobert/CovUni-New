//
//  SettingsStudentViewController.h
//  CU Mobile
//
//  Created by Robert Varga on 30/12/2012.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuStudentViewController.h"

//urls for CRUD operations on server
#define kLogOutURL @"http://robert-varga.com/cov_uni_app/index.php/account/authenticate"
#define kDataURL @"http://robert-varga.com/cov_uni_app/index.php/account/details"

@interface SettingsStudentViewController : UITableViewController 

@end
