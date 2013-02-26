//
//  FileCell.m
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "FileCell.h"

@implementation FileCell
@synthesize filename, icon, bgImageView, disclosureImageView;

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

    //Filename label settings
    filename.frame = CGRectMake(60.0, 12.0, 194.0, 18.0);
    filename.numberOfLines = 2;
    [filename sizeToFit];
    
    //Icon settings
    icon.frame = CGRectMake(8.0, 4.0, 41.0, 45.0);
    
    
    //CUSTOM by interaction
    if(selected)
    {
        UIImage* bg = [UIImage imageNamed:@"ipad-list-item-selected.png"];
        UIImage* disclosureImage = [UIImage imageNamed:@"ipad-arrow-selected.png"];
        
        [bgImageView setImage:bg];
        [disclosureImageView setImage:disclosureImage];
        
        [filename setTextColor:[UIColor whiteColor]];
        [filename setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [filename setShadowOffset:CGSizeMake(0, -1)];
        
    }
    else
    {
        UIImage* bg = [UIImage imageNamed:@"ipad-list-element.png"];
        UIImage* disclosureImage = [UIImage imageNamed:@"ipad-arrow.png"];
        
        [bgImageView setImage:bg];
        [disclosureImageView setImage:disclosureImage];
        
        [filename setTextColor:[UIColor colorWithRed:0.0 green:68.0/255 blue:118.0/255 alpha:1.0]];
        [filename setShadowColor:[UIColor whiteColor]];
        [filename setShadowOffset:CGSizeMake(0, 1)];
    }
}

@end
