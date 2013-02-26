//
//  LibraryCell.h
//  CU Mobile
//
//  Created by Robert Varga on 26/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (nonatomic, strong) IBOutlet UIImageView* disclosureImageView;
@property (nonatomic, strong) IBOutlet UIImageView* bgImageView;

@end
