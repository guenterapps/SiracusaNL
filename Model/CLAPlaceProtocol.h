//
//  CLAPlaceProtocol.h
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@protocol CLAPlace <MKAnnotation>

-(UIImage *)image;
-(void)setImage:(UIImage *)image;

-(NSString *)name;
-(void)setName:(NSString *)name;


-(CLLocationCoordinate2D)coordinate;
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
