//
//  MoodleCell.m
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "MoodleCell.h"

@implementation MoodleCell

@synthesize moduleName, moduleCode, moduleLeader, thumbnail;

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


    //Module leader
    moduleLeader.frame = CGRectMake(85.0, 16.0, 145.0, 19.0);
    moduleLeader.font = [UIFont fontWithName:@"Arial" size:13.0];
    moduleLeader.textColor = [UIColor lightGrayColor];
    
    //Module name
    moduleName.frame = CGRectMake(85.0, 35.0, 206.0, 19.0);
    moduleName.font = [UIFont fontWithName:@"Arial" size:14.0];
    moduleName.textColor = [UIColor blackColor];
    [moduleName sizeToFit];
    
    //Module code
    moduleCode.frame = CGRectMake(238.0, 16.0, 56.0, 19.0);
    moduleCode.font = [UIFont fontWithName:@"Arial" size:13.0];
    moduleCode.textColor = [UIColor lightGrayColor];
    moduleCode.textAlignment = NSTextAlignmentRight;
    
    //Image
    thumbnail.frame = CGRectMake(12.0, 16.0, 60.0, 58.0);
    
    [super setSelected:selected animated:animated];

}

@end
