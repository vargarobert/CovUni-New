//
//  Annotation.h
//  Lab-8Core Location and MapKit
//
//  Created by Robert Varga on 19/11/2012.
//  Copyright (c) 2012 Robert Varga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>



@interface Annotation : NSObject <MKAnnotation>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, readonly, copy) NSString *title;

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, readonly) NSString *latLon;

-(id)initWithName:(NSString *)name coords:(CLLocationCoordinate2D)coords;


@end