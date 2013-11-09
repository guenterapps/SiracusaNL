//
//  CLAMapViewController.h
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CLAPlaceStore.h"

@interface CLAMapViewController : UIViewController <MKMapViewDelegate>


@property (nonatomic) MKCoordinateRegion region;
@property (nonatomic) CLAPlaceStore *store;
@property (nonatomic) NSArray *places;


-(MKMapView *)mapView;

@end
