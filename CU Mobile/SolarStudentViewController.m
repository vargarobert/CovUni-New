//
//  SolarStudentViewController.m
//  CU Mobile
//
//  Created by Damian on 20/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "SolarStudentViewController.h"
#import "SolarCell.h"
#import "MBProgressHUD.h"

@interface SolarStudentViewController ()
@property (nonatomic, strong) NSMutableArray *solar;

@end

@implementation SolarStudentViewController

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
    [self mbProgressHubWithSelector:@selector(solarFeed)];
    
    [self customDesign];
}

//Display progress hub (custom activity indicator)
-(void)mbProgressHubWithSelector:(SEL)mySelector {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    [hud showWhileExecuting:mySelector onTarget:self withObject:nil animated:YES];
}


-(void)solarFeed {
    NSURL *url=[NSURL URLWithString:@"http://creative.coventry.ac.uk/~sinclaig/api/index.php/solar/grades"];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"qwerty" forHTTPHeaderField:@"Token"];
    
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (urlData) {
        NSLog(@"solar: %@", [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error]);
        self.solar = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    }
    //Switch network indicator off
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //Reload UITableView data
    [self.tableView reloadData];
}


-(void)customDesign {
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.solar.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"solarCell";
    SolarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Custom background color depended on grade value
    int grade = [[[self.solar objectAtIndex:indexPath.row] objectForKey:@"grade"] intValue];
    if (grade >= 70) {
        cell.moduleResult.backgroundColor = [UIColor colorWithRed:160.0/255 green:176.0/255 blue:70.0/255 alpha:1.0];
    }
    else if ( grade < 70 && grade >= 50) {
        cell.moduleResult.backgroundColor = [UIColor colorWithRed:242.0/255 green:201.0/255 blue:78.0/255 alpha:1.0];
    }
    else if ( grade >= 40 && grade <50 ) {
        cell.moduleResult.backgroundColor = [UIColor colorWithRed:247.0/255 green:129.0/255 blue:69.0/255 alpha:1.0];
    }
    else {
        cell.moduleResult.backgroundColor = [UIColor colorWithRed:242.0/255 green:78.0/255 blue:78.0/255 alpha:1.0];
    }
    
    cell.moduleCode.text = [[self.solar objectAtIndex:indexPath.row] objectForKey:@"module"];
    cell.moduleResult.text = [[self.solar objectAtIndex:indexPath.row] objectForKey:@"grade"];
    cell.moduleName.text = [[self.solar objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
}



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
