//
//  NewsDetailViewController.m
//  CU Mobile
//
//  Created by Robert Varga on 04/03/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "MBProgressHUD.h"

@interface NewsDetailViewController ()
@property (strong, nonatomic) NSMutableDictionary *news;
@property (strong, nonatomic) NSString *calDate;
@end

@implementation NewsDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Display progress hub white selector performed on different thread
    [self mbProgressHubWithSelector:@selector(newsFeed)];

    [self customDesign];
}

-(void)customDesign {
    //background pattern
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BG-pattern.png"]];
    
    //Title design
    [self.NewsTitle setTextColor:[UIColor colorWithRed:0.0 green:68.0/255 blue:118.0/255 alpha:1.0]];
    [self.NewsTitle setShadowColor:[UIColor whiteColor]];
    [self.NewsTitle setShadowOffset:CGSizeMake(0, 1)];
    
    //Date design
    [self.NewsDate setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
    [self.NewsDate setShadowColor:[UIColor whiteColor]];
    [self.NewsDate setShadowOffset:CGSizeMake(0, 1)];
    
    //Body design
    [self.NewsBody setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
    [self.NewsBody setShadowColor:[UIColor whiteColor]];
    [self.NewsBody setShadowOffset:CGSizeMake(0, 1)];
}

//Display progress hub (custom activity indicator)
-(void)mbProgressHubWithSelector:(SEL)mySelector {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    [hud showWhileExecuting:mySelector onTarget:self withObject:nil animated:YES];
}


-(void)newsFeed {
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://robert-varga.com/cov_uni_app/index.php/news/article/id/%@",self.newsCode];
    NSURL *url=[NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (urlData) {
//        NSLog(@"urldata: %@",[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding]);
        self.news = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    }
    //Switch network indicator off
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;


    //set the view content
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //TITLE
        [self.NewsTitle setText:[self.news objectForKey:@"title"]];
        
        //DATE
        double unixTimeStamp = [[self.news objectForKey:@"timestamp"] doubleValue];
        NSTimeInterval _interval = unixTimeStamp;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
        [_formatter setLocale:[NSLocale currentLocale]];
        [_formatter setDateFormat:@"dd.MM.yyyy HH:mm"];
        NSString *_date=[_formatter stringFromDate:date];
        [self.NewsDate setText:_date];
        
        self.calDate = _date;
        
        //BODY
        CGSize maximumLabelSize = CGSizeMake(296,9999);
        CGSize expectedLabelSize = [[self.news objectForKey:@"body"] sizeWithFont:self.NewsBody.font
                                          constrainedToSize:maximumLabelSize
                                              lineBreakMode:self.NewsBody.lineBreakMode];
        //adjust the label to the new height.
        CGRect newFrame = self.NewsBody.frame;
        newFrame.size.height = expectedLabelSize.height;
        self.NewsBody.frame = newFrame;
        
        [self.NewsBody setText:[self.news objectForKey:@"body"]];
        
        
        //scroll view size
        CGSize csize = self.scrollView.contentSize;
        csize.height = self.NewsBody.frame.origin.y + self.NewsBody.frame.size.height + 15;
        self.scrollView.contentSize = csize;
    });
    
}

//Add event to calendar
- (IBAction)AddEvent:(id)sender {
    
    //Create the Event Store
    EKEventStore *eventStore = [[EKEventStore alloc]init];
        
    //Request the access to the Calendar
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted,NSError* error){
        
        //Access not granted-------------
        if(!granted){
            NSString *message = @"Unable to access calendar. Check your privacy settings to let me in!";
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Warning"
                                                               message:message
                                                              delegate:self
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles:nil,nil];
            //Show an alert message!
            //UIKit needs every change to be done in the main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                [alertView show];
            }
                           );
            
            //Access granted------------------
        }else{
            
            //Create the event and set the Label message
            NSString *labelText;
            
            //Event created
            if([self createEvent:eventStore]){
                labelText = @"Event added!";
                
                //Error occured
            }else{
                labelText = @"Something goes wrong";
            }
            
            //Add the Label to the controller view
            dispatch_async(dispatch_get_main_queue(), ^{
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/1.5, 320, 30)];
                [label setText:labelText];
                [label setTextAlignment:NSTextAlignmentCenter];
                
                //infor user with alert view
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Calendar"
                                                                    message:labelText //@"Internet connection not available"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil, nil];
        
                [alertView show];
            });
        }
    }];

}


//Event creation
-(BOOL)createEvent:(EKEventStore*)eventStore{
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    //set event details
    event.title = [self.news objectForKey:@"title"];
    event.startDate = [NSDate dateWithTimeIntervalSince1970:[[self.news objectForKey:@"timestamp"] doubleValue]];  
    event.endDate = [event.startDate dateByAddingTimeInterval:3600]; //interval by default
    event.calendar = [eventStore defaultCalendarForNewEvents];
    
    NSError *error;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&error];
    
    if (error) {
        NSLog(@"Event Store Error: %@",[error localizedDescription]);
        return NO;
    }else{
        return YES;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
