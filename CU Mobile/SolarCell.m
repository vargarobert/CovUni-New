//
//  SolarCell.m
//  CU Mobile
//
//  Created by Damian on 22/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "SolarCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation SolarCell

@synthesize moduleCode, moduleName, moduleResult;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    //Module name settings
    moduleName.frame = CGRectMake(22.0, 28.0, 194.0, 18.0);
    moduleName.font = [UIFont fontWithName:@"Arial" size:14.0];
    [moduleName sizeToFit];
    
    
    //Module code settings
    moduleCode.frame = CGRectMake(22.0, 10.0, 62.0, 21.0);
    moduleCode.font = [UIFont fontWithName:@"Arial" size:13.0];
    moduleCode.textColor = [UIColor lightGrayColor];
    
    //Module result settings
    moduleResult.frame = CGRectMake(254.0, 22.0, 35.0, 35.0);
    moduleResult.font = [UIFont fontWithName:@"Arial Bold" size:11.0];
    moduleResult.textColor = [UIColor blackColor];
    moduleResult.shadowColor = [UIColor lightGrayColor];
    moduleResult.shadowOffset = CGSizeMake(1.0, 1.0);
    moduleResult.layer.cornerRadius = 5.0;
    moduleResult.layer.masksToBounds = YES;
    moduleResult.layer.borderColor = [UIColor grayColor].CGColor;
    moduleResult.layer.borderWidth = 1.0;
    
    
}

@end
