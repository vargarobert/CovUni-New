//
//  SolarCell.m
//  CU Mobile
//
//  Created by Damian on 22/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "SolarCell.h"

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
    moduleName.frame = CGRectMake(22.0, 26.0, 194.0, 33.0);
    moduleName.font = [UIFont fontWithName:@"Arial" size:13.0];
    moduleName.numberOfLines = 2;
    
    
    //Module code settings
    moduleCode.frame = CGRectMake(7.0, 26.0, 62.0, 21.0);
    moduleCode.font = [UIFont fontWithName:@"Arial" size:13.0]
    moduleCode.textColor = [UIColor lightGrayColor];
    
    //Module result settings
    moduleResult.frame = CGRectMake(254.0, 16.0, 46.0, 43.0);
    moduleResult.font = [UIFont fontWithName:@"Arial Bold" size:12.0];
    views.textColor = [UIColor lightGrayColor];
    
    //Date label settings
    date.frame = CGRectMake(112.0, 13.0, 90.0, 14.0);
    date.font = [UIFont fontWithName:@"Arial" size:12.0];
    date.textColor = [UIColor lightGrayColor];
    
    //Time label settings
    time.frame = CGRectMake(112.0, 65.0, 60.0, 14.0);
    time.font = [UIFont fontWithName:@"Arial-BoldMT" size:12.0];
    time.textColor = [UIColor blackColor];
}

@end
