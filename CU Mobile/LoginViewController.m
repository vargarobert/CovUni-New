//
//  ViewController.m
//  CU Mobile
//
//  Created by Robert Varga on 28/12/2012.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"

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

-(void)postMessage:(NSString*) message withName:(NSString *) name {
    if (name != nil && message != nil) {
        
        NSMutableString *postString = [NSMutableString stringWithString:kPostURL];
        [postString appendString:[NSString stringWithFormat:@"?%@=%@", kName, name]];
        [postString appendString:[NSString stringWithFormat:@"&%@=%@", kMessage, message]];
        //encode string
        [postString setString:[postString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString]];
        [request setHTTPMethod:@"POST"];
        
        postConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        
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
    
    @try {
        
        if([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""] ) {
            [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@",self.usernameField.text,self.passwordField.text];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://creative.coventry.ac.uk/~sinclaig/api/index.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %d", [response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                SBJsonParser *jsonParser = [SBJsonParser new];
                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                NSLog(@"%@",jsonData);
                NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                NSLog(@"%d",success);
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                    [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    
                } else {
                    
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                    [self alertStatus:error_msg :@"Login Failed!"];
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Login Failed!"];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
}

- (IBAction)guestButton:(id)sender {
    NSString *username = self.usernameField.text;
    [self.userDefaults setObject:username forKey:@"username"];
    [self.userDefaults synchronize];
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
