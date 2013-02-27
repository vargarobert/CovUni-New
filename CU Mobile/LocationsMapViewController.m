//
//  LocationsMapViewController.m
//  CU Mobile
//
//  Created by Robert Varga on 27/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "LocationsMapViewController.h"

@interface LocationsMapViewController ()

@end

@implementation LocationsMapViewController
@synthesize locationTitle;

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
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = self.locationTitle;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
