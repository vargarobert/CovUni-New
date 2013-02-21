//
//  YouTubeCell.m
//  CU Mobile
//
//  Created by Damian on 14/01/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "YouTubeCell.h"

@implementation YouTubeCell
@synthesize image, title, views, date, time;

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
    //Image settings
    image.frame = CGRectMake(10.0, 13.0, 88.0, 63.0);
    image.layer.cornerRadius = 10.0;
    image.layer.masksToBounds = YES;
    image.layer.borderColor = [UIColor blackColor].CGColor;
    image.layer.borderWidth = 1.0;
    
    //Title label settings
    title.frame = CGRectMake(112.0, 29.0, 180.0, 15);
    title.font = [UIFont fontWithName:@"Arial" size:13.0];
    [title sizeToFit];
    
    //Views label settings
    views.frame = CGRectMake(214.0, 65.0, 93.0, 14.0);
    views.font = [UIFont fontWithName:@"Arial" size:12.0];
    views.textColor = [UIColor lightGrayColor];
    
    //Date label settings
    date.frame = CGRectMake(112.0, 13.0, 90.0, 14.0);
    date.font = [UIFont fontWithName:@"Arial" size:12.0];
    date.textColor = [UIColor lightGrayColor];
    
    //Time label settings
    time.frame = CGRectMake(112.0, 65.0, 60.0, 14.0);
    time.font = [UIFont fontWithName:@"Arial-BoldMT" size:12.0];
    time.textColor = [UIColor blackColor];
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
