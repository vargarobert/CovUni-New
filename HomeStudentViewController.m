//
//  HomeStudentViewController.m
//  CU Mobile
//
//  Created by Robert Varga on 24/01/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "HomeStudentViewController.h"
#import "MBProgressHUD.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"


@interface HomeStudentViewController ()
@property NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSMutableArray *news;

@end

@implementation HomeStudentViewController

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

    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[self.userDefaults stringForKey:@"token"]);
    
    
    
    //Veryfy if LOGGED IN
    if (![self.userDefaults stringForKey:@"token"]) {
        UIViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"loginPopUp"];
        [self presentViewController:login animated:NO completion:nil];
    }
    
    //if there is internet connection, load news
//    if ([self pingServer]) {
//        NSLog(@"mergee");
        //Display progress hub white selector performed on different thread
        [self mbProgressHubWithSelector:@selector(newsFeed)];
//    } else {
//        //alert the user that there is no internet connection
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error loading content"
//                                                            message:@"Internet connection not available"
//                                                           delegate:self
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil, nil];
//        
//        [alertView show];
//    }

    
    
    //custom view design
    [self customDesign];
    //menu view on the right
    [self sidebarMenu];
}


//check for internet connection (reachability)
//- (BOOL) pingServer {                   //address that is always available
//    NSURL *url = [NSURL URLWithString:@"http://google.com/"];
//    NSURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSHTTPURLResponse *response = nil;
//    [NSURLConnection sendSynchronousRequest:request
//                          returningResponse:&response error:NULL];
//    return (response != nil);
//}

//Display progress hub (custom activity indicator)
-(void)mbProgressHubWithSelector:(SEL)mySelector {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    [hud showWhileExecuting:mySelector onTarget:self withObject:nil animated:YES];
}


//request the news from web services
-(void)newsFeed {
    NSString *url = [NSString stringWithFormat:kDataURL];
    NSURL *jsonUrl = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:jsonUrl];
    NSError *error;
    if (data) {
        self.news = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    }
    //Switch network indicator off
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //Reload UITableView data
    [self.tableView reloadData];
}

//SIDEBAR MENU
-(void)sidebarMenu {
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeStudent"];
    newTopViewController.view.layer.shadowOpacity = 0.75f;
    newTopViewController.view.layer.shadowRadius = 10.0f;
    newTopViewController.view.layer.shadowColor = [UIColor blackColor].CGColor;

    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuStudentViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuStudentView"];
    }
    //panGesture not working properly
//    [self.view addGestureRecognizer:self.slidingViewController.panGesture];

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // Configure the cell...
    NSDictionary *item = [self.news objectAtIndex:indexPath.row];
    
    cell.title.text = [item objectForKey:@"title"];
    cell.content.text = [item objectForKey:@"description"];


    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"newsDetailSegue"]) {
        NSIndexPath *cellPath = [self.tableView indexPathForCell:sender];
        NSString *newsCode = [[self.news objectAtIndex:cellPath.row] objectForKey:@"id"];
        NewsDetailViewController *mvc = [segue destinationViewController];
        mvc.newsCode = newsCode;
    }
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
