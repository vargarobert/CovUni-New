//
//  SolarCell.h
//  CU Mobile
//
//  Created by Damian on 22/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SolarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *moduleCode;
@property (weak, nonatomic) IBOutlet UILabel *moduleName;
@property (weak, nonatomic) IBOutlet UILabel *moduleResult;
@property (nonatomic, strong) IBOutlet UIImageView* bgImageView;


@end
