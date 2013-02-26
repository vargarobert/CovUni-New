//
//  InitialSlidingViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 1/25/12.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import "InitialSlidingViewController.h"

@implementation InitialSlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    UIStoryboard *storyboard;
  
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    }
  
    self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeStudent"];
    
    //set shadow to top view
    self.topViewController.view.layer.shadowOpacity = 0.75f;
    self.topViewController.view.layer.shadowRadius = 10.0f;
    self.topViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
