//
//  MoodleModuleDetailsViewController.m
//  CU Mobile
//
//  Created by Damian on 25/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "MoodleModuleDetailsViewController.h"
#import "MBProgressHUD.h"
#import "FileCell.h"
#import "MoodleFileViewController.h"

@interface MoodleModuleDetailsViewController ()

@end

@implementation MoodleModuleDetailsViewController


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
    [self mbProgressHubWithSelector:@selector(moduleFeed)];
    
    //background pattern
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"BG-pattern.png"]];
}

//Display progress hub (custom activity indicator)
-(void)mbProgressHubWithSelector:(SEL)mySelector {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    [hud showWhileExecuting:mySelector onTarget:self withObject:nil animated:YES];
}


-(void)moduleFeed {
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://creative.coventry.ac.uk/~sinclaig/api/index.php/moodle/files/id/%@",self.moduleId];
    NSURL *url=[NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"qwerty" forHTTPHeaderField:@"Token"];
    
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (urlData) {
        NSLog(@"urldata: %@",[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding]);
        self.moduleFiles = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    }
    //Switch network indicator off
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //Reload UITableView data
    [self.tableView reloadData];
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
    return self.moduleFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"fileCell";
    FileCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Configure Cell
    cell.filename.text = [[self.moduleFiles objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    NSString *type = [[NSString alloc] initWithFormat:@"%@",[[self.moduleFiles objectAtIndex:indexPath.row] objectForKey:@"type"]];
    
    //Types of files (set icons)
    if ([type isEqualToString:@".html"] ) {
        cell.icon.image = [UIImage imageNamed:@"Internet.png"];
    }
    else if ([type isEqualToString:@".txt"] ) {
        cell.icon.image = [UIImage imageNamed:@"txt.png"];
    }
    else if ([type isEqualToString:@".pdf"] ) {
        cell.icon.image = [UIImage imageNamed:@"PDF.png"];
    }
    else if ([type isEqualToString:@".zip"] ) {
        cell.icon.image = [UIImage imageNamed:@"Zip.png"];
    }
    else if ([type isEqualToString:@".docx"] ) {
        cell.icon.image = [UIImage imageNamed:@"Word.png"];
    }
    else if ([type isEqualToString:@".pptx"] ) {
        cell.icon.image = [UIImage imageNamed:@"Powerpoint.png"];
    }
    else if ([type isEqualToString:@".xlsx"] ) {
        cell.icon.image = [UIImage imageNamed:@"Excel.png"];
    }
    else {
        cell.icon.image = [UIImage imageNamed:@"Unknown.png"];
    };
    
//    NSLog(@"url: %@",[NSString stringWithFormat:@"%@",[[self.moduleFiles objectAtIndex:indexPath.row] objectForKey:@"url"]]);

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"moduleFileSegue"]) {
        NSIndexPath *cellPath = [self.tableView indexPathForCell:sender];
        NSString *fileURL = [[self.moduleFiles objectAtIndex:cellPath.row] objectForKey:@"url"];
        MoodleFileViewController *mmdvc = [segue destinationViewController];
        //send the file URL to the web view
        mmdvc.fileURLString = fileURL;
        
        NSString *fileTitle = [[self.moduleFiles objectAtIndex:cellPath.row] objectForKey:@"name"];
        mmdvc.fileTitle = fileTitle;
    }
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
