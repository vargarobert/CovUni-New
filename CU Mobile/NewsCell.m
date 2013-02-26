//
//  NewsCell.m
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell
@synthesize title, content, bgImageView, disclosureImageView;

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
    title.frame = CGRectMake(20.0, 11.0, 260.0, 16.0);
    title.numberOfLines = 2;
    [title sizeToFit];
        //Title label settings
    content.frame = CGRectMake(20.0, 46.0, 260.0, 16.0);
    content.numberOfLines = 3;
    [content sizeToFit];
    
    
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
        
        
        [content setTextColor:[UIColor whiteColor]];
        [content setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [content setShadowOffset:CGSizeMake(0, -1)];
        
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
        
        
        [content setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
        [content setShadowColor:[UIColor whiteColor]];
        [content setShadowOffset:CGSizeMake(0, 1)];
    }
    
    
    [super setSelected:selected animated:animated];

}

@end
