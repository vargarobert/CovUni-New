//
//  ViewController.m
//  CU Mobile
//
//  Created by Robert Varga on 28/12/2012.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface LoginViewController ()
@property NSUserDefaults *userDefaults;
@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self customDesign];
    [self animSettings];
    
}

//authorise the user
-(void)loginAuth {
    
    if([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""] ) {
        
        [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        self.usernameField.text = @"";
        self.passwordField.text = @"";
        
    } else {
        NSString *keys = [NSString stringWithFormat:@"username=%@&password=%@",self.usernameField.text,self.passwordField.text];
        
        NSURL *url=[NSURL URLWithString:kPostURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[keys dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLResponse *response;
        NSError *error;
        NSData *loginData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSArray *json = [NSJSONSerialization JSONObjectWithData:loginData options:kNilOptions error:&error];
        NSLog(@"response data: %@", json);
        if ([[json valueForKey:@"status"] isEqualToString:@"INVALID_LOGIN"]) {
            NSLog(@"error");
            [self alertStatus:@"Please revise your login credentials" :@"Login Failed!"];
            self.usernameField.text = @"";
            self.passwordField.text = @"";
        } else {
            [self.userDefaults setObject:[json valueForKey:@"token"] forKey:@"username"];
            [self.userDefaults synchronize];
            //dismiss LOGIN view
            [self dismissViewControllerAnimated:NO completion:nil];

            NSLog(@"SUCCESS %@", [json valueForKey:@"token"]);
        }
    }
}


//custom design method
-(void)customDesign {
    //text field custom design
    self.passwordField.layer.borderColor = [UIColor colorWithRed:1.0/255.0 green:99.0/255.0 blue:159.0/255.0 alpha:1.0].CGColor;
    self.passwordField.layer.borderWidth = 3.0f;
    self.passwordField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    //username
    self.usernameField.layer.borderColor = [UIColor colorWithRed:1.0/255.0 green:99.0/255.0 blue:159.0/255.0 alpha:1.0].CGColor;
    self.usernameField.layer.borderWidth = 3.0f;
    //self.usernameField.layer.cornerRadius = 15;
    self.usernameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    
    //guest button
    self.guestButtonOutlet.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.guestButtonOutlet.layer.borderColor = [UIColor colorWithRed:1.0/255.0 green:99.0/255.0 blue:159.0/255.0 alpha:1.0].CGColor;
    self.guestButtonOutlet.layer.borderWidth = 3.5f;
    
    //login button
    self.loginButtonOutlet.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.loginButtonOutlet.layer.borderColor = [UIColor colorWithRed:1.0/255.0 green:99.0/255.0 blue:159.0/255.0 alpha:1.0].CGColor;
    self.loginButtonOutlet.layer.borderWidth = 3.5f;
    
    //background pattern
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"loginBackground.jpg"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//animation settings
-(void)animSettings {
    // custom elements for animation
    int imageSize = .8 * self.view.frame.size.width;
    int borderW = (self.view.frame.size.width - imageSize) / 2;
    int borderH = (self.view.frame.size.height - imageSize) / 2;
    
    UIImageView *imageToMove = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CoventryUniversityLogo.png"]];
    imageToMove.frame = CGRectMake(borderW, borderH, imageSize, imageSize);
    [self.view addSubview:imageToMove];
    
    // Animate
    [self moveImage:imageToMove duration:0.5 curve:UIViewAnimationCurveLinear x:0.0 y:borderH];
    [self fadeLogin];
}

- (void)moveImage:(UIImageView *)image duration:(NSTimeInterval)duration curve:(int)curve x:(CGFloat)x y:(CGFloat)y {
    
    // Setup the animation
    [UIView beginAnimations:@"slideLogo" context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    // The transform matrix
    CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
    image.transform = transform;
    // Commit the changes
    [UIView commitAnimations];
}

- (void)fadeLogin {
    UIView *usernameView = [[self.view subviews] objectAtIndex:0];
    UIView *passwordView = [[self.view subviews] objectAtIndex:1];
    UIView *loginView = [[self.view subviews] objectAtIndex:2];
    UIView *guestView = [[self.view subviews] objectAtIndex:3];
    
    [UIView beginAnimations:@"fadeLogin" context:nil];
    [UIView setAnimationDelay:.3];
    [UIView setAnimationDuration:.7];
    usernameView.alpha = 1;
    passwordView.alpha = 1;
    loginView.alpha = 1;
    guestView.alpha = 1;
    [UIView commitAnimations];
}

//remove keyboard when backround is tapped
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

//keyboard controls
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.passwordField) {
        [theTextField resignFirstResponder];
    } else if (theTextField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    }
    return YES;
}

- (void)viewDidUnload {
    [self setPasswordField:nil];
    [self setUsernameField:nil];
    [self setLoginButtonOutlet:nil];
    [self setGuestButtonOutlet:nil];
    [super viewDidUnload];
}

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

- (IBAction)loginButton:(id)sender {
    //dismiss keyboard
    [self.view endEditing:YES];
    
    [self loginAuth];
}

- (IBAction)guestButton:(id)sender {
    NSString *token = @"guest";
    [self.userDefaults setObject:token forKey:@"token"];
    [self.userDefaults synchronize];
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
