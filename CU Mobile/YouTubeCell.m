//
//  YouTubeCell.m
//  CU Mobile
//
//  Created by Damian on 14/01/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "YouTubeCell.h"


@implementation YouTubeCell
@synthesize image, title, views, date, time, bgImageView, disclosureImageView;

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
    title.frame = CGRectMake(112.0, 24.0, 180.0, 15.0);
    [title sizeToFit];
    
    //Views label settings
    views.frame = CGRectMake(214.0, 62.0, 93.0, 14.0);
    [views sizeToFit];
    
    //Date label settings
    date.frame = CGRectMake(112.0, 11.0, 90.0, 14.0);
    [date sizeToFit];
    
    //Time label settings
    time.frame = CGRectMake(112.0, 62.0, 60.0, 14.0);
    [time sizeToFit];
    
    
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
        
        
        [date setTextColor:[UIColor whiteColor]];
        [date setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [date setShadowOffset:CGSizeMake(0, -1)];
        
        [time setTextColor:[UIColor whiteColor]];
        [time setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [time setShadowOffset:CGSizeMake(0, -1)];
        
        [views setTextColor:[UIColor whiteColor]];
        [views setShadowColor:[UIColor colorWithRed:25.0/255 green:96.0/255 blue:148.0/255 alpha:1.0]];
        [views setShadowOffset:CGSizeMake(0, -1)];
        
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
        
        
        [date setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
        [date setShadowColor:[UIColor whiteColor]];
        [date setShadowOffset:CGSizeMake(0, 1)];
        
        [time setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
        [time setShadowColor:[UIColor whiteColor]];
        [time setShadowOffset:CGSizeMake(0, 1)];
        
        [views setTextColor:[UIColor colorWithRed:113.0/255 green:133.0/255 blue:148.0/255 alpha:1.0]];
        [views setShadowColor:[UIColor whiteColor]];
        [views setShadowOffset:CGSizeMake(0, 1)];
    }
    
    
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
