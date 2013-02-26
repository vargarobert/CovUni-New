//
//  MenuStudentViewController.m
//  CU Mobile
//
//  Created by Robert Varga on 11/01/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "MenuStudentViewController.h"
#import "MenuCell.h"


@interface MenuStudentViewController ()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *menuIcons;

@end

@implementation MenuStudentViewController

- (void)awakeFromNib
{
    self.menuItems = [NSArray arrayWithObjects:@"Home", @"Moodle", @"Library", @"Solar", @"Locations", @"YouTube", @"Twitter", @"Settings", nil];
    self.menuIcons = [NSArray arrayWithObjects:@"news.png", @"moodle.png", @"library.png", @"solar.png", @"locations.png", @"youtube.png", @"twitternew.png", @"settings.png", nil];
}

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
    
    
    //background
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BG-pattern.png"]];


    [self.slidingViewController setAnchorRightRevealAmount:210.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    // nav bar
    self.navigationItem.title = @"Menu                   ";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"menu_bar.jpg"] forBarMetrics:UIBarMetricsDefault];
    

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
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];



    // Configure the cell...
    cell.textLabel.text = [self.menuItems objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.menuIcons objectAtIndex:indexPath.row]];


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
    NSString *identifier = [NSString stringWithFormat:@"%@Student", [self.menuItems objectAtIndex:indexPath.row]];
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}



@end
