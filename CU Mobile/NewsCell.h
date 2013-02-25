//
//  NewsCell.h
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
