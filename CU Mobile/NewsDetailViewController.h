//
//  NewsDetailViewController.h
//  CU Mobile
//
//  Created by Robert Varga on 04/03/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface NewsDetailViewController : UIViewController

@property (nonatomic, strong) NSString *newsCode;
@property (weak, nonatomic) IBOutlet UILabel *NewsTitle;
@property (weak, nonatomic) IBOutlet UILabel *NewsDate;
@property (weak, nonatomic) IBOutlet UILabel *NewsBody;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (BOOL)createEvent:(EKEventStore*)eventStore;
- (IBAction)AddEvent:(id)sender;


@end
