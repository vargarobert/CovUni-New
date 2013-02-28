//
//  LocationsMapViewController.h
//  CU Mobile
//
//  Created by Robert Varga on 27/02/2013.
//  Copyright (c) 2013 Robert Varga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NSMutableArray+PlistOperations.h"


@interface LocationsMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSString *locationTitle;
@property NSInteger locationid;

@end
