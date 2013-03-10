//
//  TwitterDetailViewController.h
//  CU Mobile
//
//  Created by Robert Varga on 08/03/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterDetailViewController : UIViewController

//transmited from main view
@property (nonatomic, strong) NSString *Title;
@property (nonatomic, strong) NSString *Body;


@property (weak, nonatomic) IBOutlet UILabel *TwitterTitle;
@property (weak, nonatomic) IBOutlet UILabel *TwitterBody;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
