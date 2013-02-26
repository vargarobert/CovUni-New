//
//  FileCell.h
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *filename;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (nonatomic, strong) IBOutlet UIImageView* disclosureImageView;
@property (nonatomic, strong) IBOutlet UIImageView* bgImageView;

@end
