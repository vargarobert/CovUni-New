//
//  LibraryCell.m
//  CU Mobile
//
//  Created by Robert Varga on 26/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "LibraryCell.h"

@implementation LibraryCell
@synthesize title, author, bgImageView, disclosureImageView;

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
    //GENERAL settings
    //Title label settings
    title.frame = CGRectMake(20.0, 11.0, 260.0, 38.0);
    title.numberOfLines = 3;
    [title sizeToFit];
    //Title label settings
    author.frame = CGRectMake(20.0, 46.0, 260.0, 29.0);
    author.numberOfLines = 2;
    [author sizeToFit];
    
    
    //CUSTOM by interaction
    if(selected)
    {
        UIImage* bg = [UIImage imageNamed:@"ipad-list-item-selected.png"];
        UIImage* disclosureImage = [UIImage imageNamed:@"ipad-arrow-selected.png"];
        
        [bgImageView setImage:bg];
        [disclosureImageView setImage:disclosureImage];
        
        [title setTextColor:[UIColor whiteColor]];
        [title setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [title setShadowOffset:CGSizeMake(0, -1)];
        
        
        [author setTextColor:[UIColor whiteColor]];
        [author setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [author setShadowOffset:CGSizeMake(0, -1)];
        
    }
    else
    {
        UIImage* bg = [UIImage imageNamed:@"ipad-list-element.png"];
        UIImage* disclosureImage = [UIImage imageNamed:@"ipad-arrow.png"];
        
        [bgImageView setImage:bg];
        [disclosureImageView setImage:disclosureImage];
        
        [title setTextColor:[UIColor colorWithRed:0.0 green:68.0/255 blue:118.0/255 alpha:1.0]];
        [title setShadowColor:[UIColor whiteColor]];
        [title setShadowOffset:CGSizeMake(0, 1)];
        
        
        [author setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
        [author setShadowColor:[UIColor whiteColor]];
        [author setShadowOffset:CGSizeMake(0, 1)];
    }
    
    
    [super setSelected:selected animated:animated];
    
}

@end
