//
//  MoodleFileViewController.m
//  CU Mobile
//
//  Created by Robert Varga on 05/03/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "MoodleFileViewController.h"
#import "MBProgressHUD.h"

@interface MoodleFileViewController ()

@end

@implementation MoodleFileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set naviation bar TITLE
    self.navigationItem.title = self.fileTitle;
    
    //Display progress hub white selector performed on different thread
    [self mbProgressHubWithSelector:@selector(loadFileData)];
}

//Display progress hub (custom activity indicator)
-(void)mbProgressHubWithSelector:(SEL)mySelector {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    [hud showWhileExecuting:mySelector onTarget:self withObject:nil animated:YES];
}

-(void)loadFileData {
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:self.fileURLString];
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //Load the request in the UIWebView.
    [self.fileWebView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
