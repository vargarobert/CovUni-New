//
//  WatchVideoStudentViewController.m
//  CU Mobile
//
//  Created by Damian on 27/01/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "WatchVideoStudentViewController.h"


@interface WatchVideoStudentViewController ()

@end

@implementation WatchVideoStudentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.watchVideo.delegate = self;
    
    float width = 300.0f;
    float height = 180.0f;

    NSMutableString *html = [[NSMutableString alloc] initWithCapacity:1];
    [html appendString:@"<html><head>"];
    [html appendString:@"<style type=\"text/css\">"];
    [html appendString:@"body {"];
    [html appendString:@"background-color: black;"];
    [html appendString:@"color: black;"];
    [html appendString:@"}"];
    [html appendString:@"</style>"];
    [html appendString:@"</head><body style=\"margin:100 10 0 10\">"];
    [html appendFormat:@"<embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\"", self.youTubeURL];
    [html appendFormat:@"width=\"%f\" height=\"%f\"></embed>", width, height];
    [html appendString:@"</body></html>"];

    [self.watchVideo setBackgroundColor:[UIColor blackColor]];
    [self.watchVideo loadHTMLString:html baseURL:nil];

    
    
}



-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
