//
//  YouTubeStudentViewController.m
//  CU Mobile
//
//  Created by Damian on 14/01/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "YouTubeStudentViewController.h"
#import "YouTubeCell.h"
#import "LoadMoreCell.h"
#import "WatchVideoStudentViewController.h"
#import "MBProgressHUD.h"



@interface YouTubeStudentViewController ()

@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, strong) LoadMoreCell *loadCell;
@property (assign) BOOL enableLoadMoreCell;

@end

@implementation YouTubeStudentViewController

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
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //Display progress hub white selector performed on different thread
    [self mbProgressHubWithSelector:@selector(youtubeFeed)];

    [self customDesign];
}

//Display progress hub (custom activity indicator)
-(void)mbProgressHubWithSelector:(SEL)mySelector {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    [hud showWhileExecuting:mySelector onTarget:self withObject:nil animated:YES];
}


//Youtube json feed
-(void)youtubeFeed {
    NSString *url = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?author=covstudent&orderby=published&max-results=10&v=2&alt=jsonc"];
    NSURL *jsonUrl = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:jsonUrl];
    NSError *error;
    if (data) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSDictionary *jsonData = [json objectForKey:@"data"];
        self.videos = [jsonData objectForKey:@"items"];
        NSLog(@"%@",[jsonData objectForKey:@"items"]);
    }
    //Switch network indicator off
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //Reload UITableView data
    [self.tableView reloadData];
}

//Load next 10 videos
-(void)youtubeFeedMore {
    int results = self.videos.count + 1;
    NSString *url = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?author=covstudent&orderby=published&max-results=10&start-index=%i&v=2&alt=jsonc",results];
    NSURL *jsonUrl = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:jsonUrl];
    NSError *error;
    NSArray *newData = [NSArray new];
    if (data) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSDictionary *jsonData = [json objectForKey:@"data"];
        newData = [jsonData objectForKey:@"items"];
        NSLog(@"%@",[jsonData objectForKey:@"items"]);
    }
    self.videos = [self.videos mutableCopy];
    [self.videos addObjectsFromArray:newData];
    
    //Activity indicator for loadmore cell
    [self.loadCell.loadMoreActivityIndicator stopAnimating];
    
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
    return self.videos.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Show empty table if there is no data
    if (self.videos.count == 0) {
        UITableViewCell *cell = [UITableViewCell new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    //Last cell in UITableView will be cell of class LoadMoreCell
    else if (indexPath.row == self.videos.count) {
        static NSString *LoadMoreIdentifier = @"MoreCell";
        LoadMoreCell *loadCell = [LoadMoreCell new];
        self.loadCell = [tableView dequeueReusableCellWithIdentifier:LoadMoreIdentifier forIndexPath:indexPath];
        loadCell.title.text = @"load more";
        self.enableLoadMoreCell = YES;
        return loadCell;
    }
    
    //Configuring the cell
    static NSString *CellIdentifier = @"VideoCell";
    YouTubeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Title
    cell.title.text = [[self.videos objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.title.numberOfLines = 2;
    
    //Image using SDWebCache library for lazy loading
    NSDictionary *thumbnail = [[self.videos objectAtIndex:indexPath.row] objectForKey:@"thumbnail"];
    NSURL *imageURL = [NSURL URLWithString:[thumbnail  objectForKey:@"sqDefault"]];
    [cell.image setImageWithURL:imageURL];
    
    //Video views count
    cell.views.text = [NSString stringWithFormat:@"Views: %@",[[self.videos objectAtIndex:indexPath.row] objectForKey:@"viewCount" ]];
    
    //Video upload date
    NSString *formattedString = [[[self.videos objectAtIndex:indexPath.row] objectForKey:@"uploaded"] stringByReplacingOccurrencesOfString:@"T" withString:@""];
    formattedString = [formattedString stringByReplacingCharactersInRange:NSMakeRange(18, 5) withString:@""];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-ddHH:mm:ss"];
    NSDate *date = [df dateFromString:formattedString];
    NSLog(@"%@",date);
    [df setDateFormat:@"dd/MM/yyyy"];
    NSString *dateStr = [df stringFromDate:date];
    cell.date.text = dateStr;
    
 
    

    
    //Video duration
    NSString *duration = [NSString stringWithFormat:@"%@",[[self.videos objectAtIndex:indexPath.row] objectForKey:@"duration" ]];
    int timeInt = [duration integerValue];
    int hours = timeInt / 3600;
    int minutes = (timeInt / 60) - (hours * 60) ;
    double seconds = timeInt % 60;
    if (!hours == 0) {
        cell.time.text = [NSString stringWithFormat:@"%i:%i:%02g",hours,minutes,seconds];
    }
    else {
        cell.time.text = [NSString stringWithFormat:@"%i:%02g",minutes,seconds];
    }
    
        return cell;

}


#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"watchSeque"]) {
        //NSLog(@"watch video seque triggered seque data: %@",sender);
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSDictionary *youTubeMovie = [[self.videos objectAtIndex:indexPath.row] objectForKey:@"player"];
        NSArray *youTubeMovieURLArray = [[youTubeMovie objectForKey:@"default"] componentsSeparatedByString:@"v="];
        NSArray *youTubeMovieURLArrayNew = [[youTubeMovieURLArray objectAtIndex:1] componentsSeparatedByString:@"&"];
        NSString *youTubeMovieURLString = [youTubeMovieURLArrayNew objectAtIndex:0];
        //NSLog(@"url: %@",youTubeMovieURLString);
        WatchVideoStudentViewController *newView = [segue destinationViewController];
        newView.youTubeURL = [NSString stringWithFormat:@"http://www.youtube.com/v/%@",youTubeMovieURLString];
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Load more json data if loadmore cell tapped
    if (indexPath.row == self.videos.count && self.enableLoadMoreCell == YES) {
        self.enableLoadMoreCell = NO;
        self.loadCell.title.text = @"loading...";
        
        //Activity indicators for loadmore cell
        [self.loadCell.loadMoreActivityIndicator startAnimating];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [self performSelectorInBackground:@selector(youtubeFeedMore) withObject:nil];
    }

    
}

//Customised cell heights
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.videos.count) {
        return 60.0;
    }
    return 90.0;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


@end
