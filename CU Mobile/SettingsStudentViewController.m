//
//  SettingsStudentViewController.m
//  CU Mobile
//
//  Created by Robert Varga on 30/12/2012.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import "SettingsStudentViewController.h"
#import "MBProgressHUD.h"

@interface SettingsStudentViewController ()
@property NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSMutableDictionary *userData;
@end

@implementation SettingsStudentViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init with user defaults
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    //get user data
    [self mbProgressHubWithSelector:@selector(fetchUserData)];
    
    //customize the view
    [self customDesign];
}

-(void)customDesign {
    //background pattern
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BG-pattern.png"]];
    
    // nav bar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //back button color  #2974c3
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:41.0/255.0f green:116.0/255.0f blue:195.0/255.0f alpha:1.0]];
    
    //settings button
    UIImage* settingsImage = [UIImage imageNamed:@"ButtonMenu.png"];
    CGRect frameimg = CGRectMake(0, 0, settingsImage.size.width, settingsImage.size.height);
    UIButton *uiSettingsButton = [[UIButton alloc] initWithFrame:frameimg];
    [uiSettingsButton setBackgroundImage:settingsImage forState:UIControlStateNormal];
    [uiSettingsButton addTarget:self action:@selector(menuButton) forControlEvents:UIControlEventTouchUpInside];
    [uiSettingsButton setShowsTouchWhenHighlighted:YES];
    //add buton to navbar
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:uiSettingsButton];
    self.navigationItem.leftBarButtonItem = settingsButton;
}

//Display progress hub (custom activity indicator)
-(void)mbProgressHubWithSelector:(SEL)mySelector {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    [hud showWhileExecuting:mySelector onTarget:self withObject:nil animated:YES];
}


//request the news from web services
-(void)fetchUserData {
    NSURL *url = [NSURL URLWithString:@"http://creative.coventry.ac.uk/~sinclaig/api/index.php/account/details"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    //secure request, via token
    [request setValue:@"qwerty" forHTTPHeaderField:@"Token"];
    
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (urlData) {
//        NSLog(@"urldata: %@",[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding]);
        self.userData = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    }
    //Switch network indicator off
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //Reload UITableView data
    [self.tableView reloadData];
}

-(void)menuButton {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
        return 3;
    else if (section == 1)
        return 2;
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"settingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //gets the path
    int indexRow = [indexPath row];
    int indexSection = [indexPath section];
    
    //set data for each cell in table view
    if (indexRow == 0 && indexSection == 0) {
        NSString *fullName = [NSString stringWithFormat:@"%@ %@",[self.userData objectForKey:@"forename"], [self.userData objectForKey:@"surname"]];
        cell.textLabel.text = fullName;
        cell.detailTextLabel.text = @"Name";
    } else if(indexRow == 1 && indexSection == 0) {
        cell.textLabel.text = [self.userData objectForKey:@"username"];
        cell.detailTextLabel.text = @"Username";
    } else if(indexRow == 2 && indexSection == 0) {
        cell.textLabel.text = [self.userData objectForKey:@"studentid"];
        cell.detailTextLabel.text = @"Student ID";
    } else if(indexRow == 0 && indexSection == 1) {
        cell.textLabel.text = [self.userData objectForKey:@"course"];
        cell.detailTextLabel.text = @"Course";
    } else if(indexRow == 1 && indexSection == 1) {
        cell.textLabel.text = [self.userData objectForKey:@"printcredits"];
        cell.detailTextLabel.text = @"Print credits";
    } else if(indexRow == 0 && indexSection == 2) {
        cell.textLabel.text = @"Sign Out";
        cell.detailTextLabel.text = @"";
    }

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int indexRow = [indexPath row];
    int indexSection = [indexPath section];
    
    //SignOut
    if (indexRow == 0 && indexSection == 2) {
        
        //Reset top view
        UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeStudent"];
        [self.slidingViewController resetTopViewWithAnimations:nil onComplete:^{
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController = newTopViewController;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
        }];

        //removes token
        [self.userDefaults setObject:NULL forKey:@"token"];
        [self.userDefaults synchronize];
        
        //UIViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"loginPopUp"];
        //[self presentViewController:login animated:YES completion:nil];
    }
    
}

@end
