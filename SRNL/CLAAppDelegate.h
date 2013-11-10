//
//  CLAAppDelegate.h
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLAPlaceStore.h"
#import "CLAPlacesTableViewController.h"
#import "CLAMapViewController.h"

@interface CLAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) CLAPlaceStore *store;

@property (nonatomic) CLAMapViewController *mapViewController;
@property (nonatomic) CLAPlacesTableViewController *placesTableViewController;

@property (nonatomic) MKCoordinateRegion italia;

@end
