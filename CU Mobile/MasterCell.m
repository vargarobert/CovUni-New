//
//  MasterCell.m
//  CU Mobile
//
//  Created by Robert Varga on 31/12/2012.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import "MasterCell.h"

@implementation MasterCell
@synthesize textLabel, imageView, bgImageView, disclosureImageView, detailTextLabel;

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
    if(selected)
    {
        UIImage* bg = [UIImage imageNamed:@"ipad-list-item-selected.png"];
        UIImage* disclosureImage = [UIImage imageNamed:@"ipad-arrow-selected.png"];
        
        [bgImageView setImage:bg];
        [disclosureImageView setImage:disclosureImage];
        
        [textLabel setTextColor:[UIColor whiteColor]];
        [textLabel setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [textLabel setShadowOffset:CGSizeMake(0, -1)];
        
        
        [detailTextLabel setTextColor:[UIColor whiteColor]];
        [detailTextLabel setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [detailTextLabel setShadowOffset:CGSizeMake(0, -1)];
        
    }
    else
    {
        UIImage* bg = [UIImage imageNamed:@"ipad-list-element.png"];
        UIImage* disclosureImage = [UIImage imageNamed:@"ipad-arrow.png"];
        
        [bgImageView setImage:bg];
        [disclosureImageView setImage:disclosureImage];
        
        [textLabel setTextColor:[UIColor colorWithRed:0.0 green:68.0/255 blue:118.0/255 alpha:1.0]];
        [textLabel setShadowColor:[UIColor whiteColor]];
        [textLabel setShadowOffset:CGSizeMake(0, 1)];
        
        
        [detailTextLabel setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
        [detailTextLabel setShadowColor:[UIColor whiteColor]];
        [detailTextLabel setShadowOffset:CGSizeMake(0, 1)];
    }
    
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
