//
//  CLAMapViewController.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAMapViewController.h"
#import "CLAAppDelegate.h"
#import "CLAPlace.h"

@interface CLAMapViewController ()

@end

@implementation CLAMapViewController

-(void)awakeFromNib
{
	UIImage *pin = [UIImage imageNamed:@"tab_pin"];
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, pin.size.width, pin.size.height)];
	
	[button setImage:[UIImage imageNamed:@"tab_pin"] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(toggleMap:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	
	[self.navigationItem setRightBarButtonItem:buttonItem];
	[self.navigationItem setTitle:@"SIRACUSA NIGHTLIFE"];
}


-(void)viewDidAppear:(BOOL)animated
{
	CLAPlace *place = [[CLAPlace alloc] init];
	
	[place setCoordinate:self.mapView.region.center];
	
	[self.mapView removeAnnotation:place];
	[self.mapView addAnnotation:place];
}

-(void)toggleMap:(id)sender
{

	CLAAppDelegate *appDelegate	= (CLAAppDelegate *)[UIApplication sharedApplication].delegate;
	
	UINavigationController *navController	= self.navigationController;

	CLAPlacesTableViewController *mainTableViewController = appDelegate.placesTableViewController;
	
	mainTableViewController.view.frame = self.view.frame;
	
	[UIView transitionFromView:self.view toView:mainTableViewController.view
					  duration:0.30
					   options:UIViewAnimationOptionTransitionFlipFromLeft
					completion:^(BOOL finished)
	 {

		[navController setViewControllers:@[mainTableViewController]];
		 
	 }];
	
}

#pragma mark --
#pragma mark MKMapView delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation
{
	static NSString *annotationView = @"annotationView";
	MKAnnotationView *aView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:annotationView];
	
	if (!aView)
		aView = [[MKAnnotationView alloc] init];
	
	[aView setImage:[UIImage imageNamed:@"pub.png"]];
	
	return aView;
}

#pragma mark --
#pragma mark helper methods

-(MKMapView *)mapView
{
	return (MKMapView *)self.view;
}

-(void)setRegion:(MKCoordinateRegion)region
{
	[self.mapView setRegion:region];
}

-(IBAction)getZone:(id)sender
{
	NSMutableDictionary *zoneToPoint = [NSMutableDictionary dictionary];
	
	MKCoordinateRegion region = [self.mapView region];
	
	
	[zoneToPoint setObject:@(region.center.longitude) forKey:@"longitude"];
	[zoneToPoint setObject:@(region.center.latitude) forKey:@"latitude"];
	[zoneToPoint setObject:@(region.span.latitudeDelta) forKey:@"latitudeDelta"];
	[zoneToPoint setObject:@(region.span.longitudeDelta) forKey:@"longitudeDelta"];
	
	NSFileManager *fm = [NSFileManager defaultManager];
	
	NSURL *pathToCoord = [[[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] URLByAppendingPathComponent:@"DefaultCoordinate"];;
	
	[zoneToPoint writeToURL:pathToCoord atomically:YES];

}

@end
