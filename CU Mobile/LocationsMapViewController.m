//
//  LocationsMapViewController.m
//  CU Mobile
//
//  Created by Robert Varga on 27/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import "LocationsMapViewController.h"
#include "Annotation.h"

@interface LocationsMapViewController ()
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation LocationsMapViewController
@synthesize locationTitle, locationid, mapView;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    self.navigationItem.title = self.locationTitle;
    
    //read from Plist file
    self.list = [NSMutableArray loadDataFromPlist:@"ListData.plist" forKey:@"locations"];    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //set MAP coordinates
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 52.406673;
    coordinate.longitude = -1.502380;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    
        //setup Annitation 
    NSMutableArray *annotattions = [[NSMutableArray alloc] init];
    
    //get annotation coordinates
    for (int i=0; i<self.list.count; ++i) {
        NSDictionary *dict = [self.list objectAtIndex:i];
        
        Annotation *i = [[Annotation alloc]initWithName:[dict objectForKey:@"name"]
                                                 coords:CLLocationCoordinate2DMake([[dict objectForKey:@"lat"] doubleValue], [[dict objectForKey:@"long"] doubleValue])];
        [annotattions addObject:i];
    }
    

    //add all pins to map
    [self.mapView addAnnotations:annotattions];
    //current pin selected (depending on choice from places table view)
    [self.mapView selectAnnotation:[annotattions objectAtIndex:self.locationid] animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
