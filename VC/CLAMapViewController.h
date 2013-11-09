//
//  CLAMapViewController.h
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CLAMapViewController : UIViewController


@property (nonatomic) MKCoordinateRegion region;


-(IBAction)getZone:(id)sender;

@end
