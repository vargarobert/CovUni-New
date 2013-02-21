//
//  MasterCell.h
//  CU Mobile
//
//  Created by Robert Varga on 31/12/2012.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* textLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) IBOutlet UIImageView* bgImageView;


@end
