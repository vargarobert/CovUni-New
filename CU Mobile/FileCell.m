//
//  FileCell.m
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "FileCell.h"

@implementation FileCell
@synthesize filename, icon;

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
    filename.font = [UIFont fontWithName:@"Arial" size:14.0];
    filename.numberOfLines = 2;
    [filename sizeToFit];
    
    //Icon settings
    icon.frame = CGRectMake(8.0, 4.0, 41.0, 45.0);

}

@end
