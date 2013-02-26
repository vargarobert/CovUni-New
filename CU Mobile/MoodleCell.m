//
//  MoodleCell.m
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "MoodleCell.h"

@implementation MoodleCell

@synthesize moduleName, moduleCode, moduleLeader, thumbnail, bgImageView, disclosureImageView;

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
    //Module leader
    moduleLeader.frame = CGRectMake(85.0, 16.0, 145.0, 19.0);
    moduleLeader.textColor = [UIColor lightGrayColor];
    
    //Module name
    moduleName.frame = CGRectMake(85.0, 35.0, 206.0, 19.0);
    [moduleName sizeToFit];
    
    //Module code
    moduleCode.frame = CGRectMake(238.0, 16.0, 56.0, 19.0);
    moduleCode.textAlignment = NSTextAlignmentRight;
    
    //Image
    thumbnail.frame = CGRectMake(12.0, 16.0, 60.0, 58.0);
    
    
    
    //CUSTOM by interaction
    if(selected)
    {
        UIImage* bg = [UIImage imageNamed:@"ipad-list-item-selected.png"];
        UIImage* disclosureImage = [UIImage imageNamed:@"ipad-arrow-selected.png"];
        
        [bgImageView setImage:bg];
        [disclosureImageView setImage:disclosureImage];
        
        [moduleName setTextColor:[UIColor whiteColor]];
        [moduleName setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [moduleName setShadowOffset:CGSizeMake(0, -1)];
        
        
        [moduleLeader setTextColor:[UIColor whiteColor]];
        [moduleLeader setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [moduleLeader setShadowOffset:CGSizeMake(0, -1)];
        
        [moduleCode setTextColor:[UIColor whiteColor]];
        [moduleCode setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [moduleCode setShadowOffset:CGSizeMake(0, -1)];
    }
    else
    {
        UIImage* bg = [UIImage imageNamed:@"ipad-list-element.png"];
        UIImage* disclosureImage = [UIImage imageNamed:@"ipad-arrow.png"];
        
        [bgImageView setImage:bg];
        [disclosureImageView setImage:disclosureImage];
        
        [moduleName setTextColor:[UIColor colorWithRed:0.0 green:68.0/255 blue:118.0/255 alpha:1.0]];
        [moduleName setShadowColor:[UIColor whiteColor]];
        [moduleName setShadowOffset:CGSizeMake(0, 1)];
        
        
        [moduleLeader setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
        [moduleLeader setShadowColor:[UIColor whiteColor]];
        [moduleLeader setShadowOffset:CGSizeMake(0, 1)];
        
        [moduleCode setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
        [moduleCode setShadowColor:[UIColor whiteColor]];
        [moduleCode setShadowOffset:CGSizeMake(0, 1)];
    }
    
    
    [super setSelected:selected animated:animated];

}

@end
