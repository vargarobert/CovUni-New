//
//  MoodleFileViewController.h
//  CU Mobile
//
//  Created by Robert Varga on 05/03/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoodleFileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *fileWebView;

@property (strong, nonatomic) NSString *fileURLString;
@property (strong, nonatomic) NSString *fileTitle;

@end
