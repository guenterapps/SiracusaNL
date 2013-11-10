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

-(void)toggleTable:(id)sender;
-(void)showDetailForPlace:(id)sender;

-(IBAction)getZone:(id)sender;

@end

@implementation CLAMapViewController

-(void)awakeFromNib
{
	UIImage *list = [UIImage imageNamed:@"listicon"];
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 46)];
	
	[button setImage:list forState:UIControlStateNormal];
	[button addTarget:self action:@selector(toggleTable:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	
	[self.navigationItem setRightBarButtonItem:buttonItem];
	[self.navigationItem setTitle:@"SIRACUSA NIGHTLIFE"];

}


-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	if (self.places)
	{
		[self.mapView removeAnnotations:self.places];
	}
	else
	{
		self.places = self.store.places;
	}

	[self.mapView addAnnotations:self.places];
}

-(void)toggleTable:(id)sender
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
	static NSString *reuseIdentifier = @"annotationView";
	MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
	
	if (!annotationView)
		annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
											 reuseIdentifier:reuseIdentifier];
	
	[annotationView setImage:[UIImage imageNamed:@"pub.png"]];
	annotationView.enabled = YES;
	annotationView.canShowCallout = YES;
	
	UIButton *callOut = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[callOut addTarget:self action:@selector(showDetailForPlace:) forControlEvents:UIControlEventTouchUpInside];
	
	annotationView.rightCalloutAccessoryView = callOut;
	
	
	return annotationView;
}

#pragma mark --
#pragma mark helper methods

-(void)showDetailForPlace:(id)sender
{
	NSLog(@"aasa");
}

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
