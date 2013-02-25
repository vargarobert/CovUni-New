//
//  TwitterStudentViewController.m
//  CU Mobile
//
//  Created by Damian on 12/01/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "TwitterStudentViewController.h"
#import "MBProgressHUD.h"

@interface TwitterStudentViewController ()
@property (nonatomic, strong) NSMutableArray *tweets;
@end

@implementation TwitterStudentViewController

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
    
    //Display progress hub white selector performed on different thread
    [self mbProgressHubWithSelector:@selector(tweetRequest)];
    
    
    [self customDesign];
}

//Display progress hub (custom activity indicator)
-(void)mbProgressHubWithSelector:(SEL)mySelector {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    [hud showWhileExecuting:mySelector onTarget:self withObject:nil animated:YES];
}


// Tweets request
-(void)tweetRequest {
    NSString *url = [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=from:covcampus"];
    NSURL *jsonUrl = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:jsonUrl];
    NSError *error;
    if (data) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        self.tweets = [json objectForKey:@"results"];
    }
    //Switch network indicator off
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //Reload UITableView data
    [self.tableView reloadData];

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
    // Return the number of sections..
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TweetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell for tweets
    cell.textLabel.text = [[self.tweets objectAtIndex:indexPath.row] objectForKey:@"from_user"];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.tweets objectAtIndex:indexPath.row] objectForKey:@"profile_image_url"]]]];
    cell.detailTextLabel.text = [[self.tweets objectAtIndex:indexPath.row] objectForKey:@"text"];
    
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)tweetButton:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Tweeting from CU app! :)"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}
@end
