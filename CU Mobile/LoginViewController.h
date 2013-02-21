//
//  ViewController.h
//  CU Mobile
//
//  Created by Robert Varga on 28/12/2012.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPostURL @"http://creative.coventry.ac.uk/~sinclaig/api/index.php"
#define kName @"name"
#define kMessage @"password"

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    NSURLConnection *postConnection;
}

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UIButton *loginButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *guestButtonOutlet;

- (IBAction)loginButton:(id)sender;
- (IBAction)guestButton:(id)sender;

@end
