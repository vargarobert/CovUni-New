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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.mapView.delegate = self;
    self.navigationItem.title = self.locationTitle;

    self.list = [NSMutableArray loadDataFromPlist:@"ListData.plist" forKey:@"locations"];    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 52.406673;
    coordinate.longitude = -1.502380;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    point.coordinate = userLocation.coordinate;
//    point.title = @"Where am I?";
//    point.subtitle = @"I'm here!!!";
//    
//    //[self.mapView addAnnotation:point];

    //locations
//    Annotation *AB = [[Annotation alloc]initWithName:@"Alan Berry" coords:CLLocationCoordinate2DMake(52.408074, -1.506071)];
//    Annotation *AS = [[Annotation alloc]initWithName:@"Armstrong Siddeley" coords:CLLocationCoordinate2DMake(52.407537, -1.500664)];
//    Annotation *CW = [[Annotation alloc]initWithName:@"Charles Ward" coords:CLLocationCoordinate2DMake(52.408192, -1.504698)];
//    Annotation *ET = [[Annotation alloc]initWithName:@"Ellen Terry" coords:CLLocationCoordinate2DMake(52.406412, -1.504548)];
//    Annotation *GE = [[Annotation alloc]initWithName:@"George Eliot" coords:CLLocationCoordinate2DMake(52.407590, -1.504891)];
//    Annotation *GS = [[Annotation alloc]initWithName:@"Graham Sutherland" coords:CLLocationCoordinate2DMake(52.406817, -1.503196)];
//    Annotation *J = [[Annotation alloc]initWithName:@"Jaguar" coords:CLLocationCoordinate2DMake(52.407053, -1.501114)];
//    Annotation *JS = [[Annotation alloc]initWithName:@"James Stanley" coords:CLLocationCoordinate2DMake(52.407210, -1.504290)];
//    Annotation *LL = [[Annotation alloc]initWithName:@"Lanchester Library" coords:CLLocationCoordinate2DMake(52.405665, -1.500921)];
//    Annotation *MF = [[Annotation alloc]initWithName:@"Maurice Foss" coords:CLLocationCoordinate2DMake(52.407406, -1.503389)];
//    Annotation *RC = [[Annotation alloc]initWithName:@"Richard Crossman" coords:CLLocationCoordinate2DMake(52.406529, -1.505535)];
//    Annotation *SpC = [[Annotation alloc]initWithName:@"Sports Centre" coords:CLLocationCoordinate2DMake(52.405613, -1.504033)];
//    Annotation *SC = [[Annotation alloc]initWithName:@"Student Centre" coords:CLLocationCoordinate2DMake(52.404697, -1.500685)];
//    Annotation *TP = [[Annotation alloc]initWithName:@"Technology Park" coords:CLLocationCoordinate2DMake(52.402367, -1.503732)];
//    Annotation *TH = [[Annotation alloc]initWithName:@"The Hub" coords:CLLocationCoordinate2DMake(52.407171, -1.504977)];
//    Annotation *TnEC = [[Annotation alloc]initWithName:@"The new EC" coords:CLLocationCoordinate2DMake(52.405273, -1.499913)];
//    Annotation *WM = [[Annotation alloc]initWithName:@"William Morris" coords:CLLocationCoordinate2DMake(52.406477, -1.500406)];

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
