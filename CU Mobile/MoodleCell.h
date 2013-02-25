//
//  MoodleCell.h
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoodleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moduleLeader;
@property (weak, nonatomic) IBOutlet UILabel *moduleCode;
@property (weak, nonatomic) IBOutlet UILabel *moduleName;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

@end
