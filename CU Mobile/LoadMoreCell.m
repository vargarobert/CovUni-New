//
//  LoadMoreCell.m
//  CU Mobile
//
//  Created by Damian on 27/01/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "LoadMoreCell.h"

@implementation LoadMoreCell
@synthesize title, loadMoreActivityIndicator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    

    

    //Title
    title.frame = CGRectMake(92.0, 16.0, 136.0, 28.0);
    title.font = [UIFont fontWithName:@"Arial" size:18.0];
    title.textColor = [UIColor lightGrayColor];
}

@end
