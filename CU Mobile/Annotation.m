//
//  Annotation.m
//  Lab-8Core Location and MapKit
//
//  Created by Robert Varga on 19/11/2012.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation


-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    self.coordinate = newCoordinate;
}

-(id)initWithName:(NSString *)name coords:(CLLocationCoordinate2D)coords
{
    if (self = [super init]) {
        _title = [name copy];
        _coordinate = coords;
    }
    
    return self;
}

-(NSString *)description
{
    NSString *title = self.title;
    float lat = self.coordinate.latitude;
    float lon = self.coordinate.longitude;
    NSString *text = [NSString stringWithFormat:@"name: %@ lat: %f lon: %f", title, lat, lon];
    
    return text;
}


@end
