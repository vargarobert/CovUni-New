//
//  LoadMoreCell.h
//  CU Mobile
//
//  Created by Damian on 27/01/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadMoreActivityIndicator;


@end
