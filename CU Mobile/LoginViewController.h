//
//  ViewController.h
//  CU Mobile
//
//  Created by Robert Varga on 28/12/2012.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

//urls for CRUD operations on server
#define kLoginURL @"http://robert-varga.com/cov_uni_app/index.php/account/authenticate"

@interface LoginViewController : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UIButton *loginButtonOutlet;


- (IBAction)loginButton:(id)sender;

@end
