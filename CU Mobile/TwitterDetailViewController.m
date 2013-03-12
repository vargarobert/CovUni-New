//
//  TwitterDetailViewController.m
//  CU Mobile
//
//  Created by Robert Varga on 08/03/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "TwitterDetailViewController.h"

@interface TwitterDetailViewController ()

@end

@implementation TwitterDetailViewController

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
    
    [self customDesign];
    
    //set nav title
    self.navigationItem.title = _Title;
    
    //BODY label
    CGSize maximumLabelSize = CGSizeMake(296,9999);
    CGSize expectedLabelSize = [_Body sizeWithFont:self.self.TwitterBody.font
                                                            constrainedToSize:maximumLabelSize
                                                                lineBreakMode:self.self.TwitterBody.lineBreakMode];
    //adjust the label to the new height.
    CGRect newFrame = self.self.TwitterBody.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.self.TwitterBody.frame = newFrame;
    
    [self.TwitterBody setText:_Body];
}

-(void)customDesign {
    //background pattern
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BG-pattern.png"]];
    
    //Title design
    [self.TwitterTitle setTextColor:[UIColor colorWithRed:0.0 green:68.0/255 blue:118.0/255 alpha:1.0]];
    [self.TwitterTitle setShadowColor:[UIColor whiteColor]];
    [self.TwitterTitle setShadowOffset:CGSizeMake(0, 1)];
    
    //Body design
    [self.TwitterBody setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
    [self.TwitterBody setShadowColor:[UIColor whiteColor]];
    [self.TwitterBody setShadowOffset:CGSizeMake(0, 1)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
