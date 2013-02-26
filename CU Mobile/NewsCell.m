//
//  NewsCell.m
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell
@synthesize title, content;

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

    //Title label settings
    title.frame = CGRectMake(20.0, 11.0, 260.0, 16.0);
//    title.font = [UIFont fontWithName:@"Arial" size:14.0];
    title.numberOfLines = 2;
    [title sizeToFit];
    
    //Title label settings
    content.frame = CGRectMake(20.0, 46.0, 260.0, 16.0);
//    content.font = [UIFont fontWithName:@"Arial" size:13.0];
    content.textColor = [UIColor grayColor];
    content.numberOfLines = 3;
    [content sizeToFit];
    
    

}

@end
