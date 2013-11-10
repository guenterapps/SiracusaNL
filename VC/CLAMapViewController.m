//
//  CLAMapViewController.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAMapViewController.h"
#import "CLADetailViewController.h"
#import "CLAAppDelegate.h"
#import "CLAPlace.h"

@interface CLAMapViewController ()
{
	CLAPlace *_placeToShowDetail;
}

-(void)toggleTable:(id)sender;
-(void)showDetailForPlace:(id)sender;

-(void)navigateToDetail:(NSTimer *)sender;

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

-(void)setRegion:(MKCoordinateRegion)region navigateToDetailMap:(BOOL)navigate
{
	self.navigateToDetailMap = navigate;
	
	[self.mapView setRegion:region];
}

#pragma mark view lifecycle

-(void)viewDidLoad
{
	[super viewDidLoad];
	
	if (self.navigateToDetailMap)
	{
		[self setupBackAndDisclosure];
	}
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
	
	if (self.navigateToDetailMap)
	{
		[NSTimer scheduledTimerWithTimeInterval:0.50 target:self selector:@selector(navigateToDetail:) userInfo:nil repeats:NO];
	}
}

-(void)navigateToDetail:(NSTimer *)sender
{
	CLAPlace *place = [self.places lastObject];
	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(place.coordinate, 500, 500);
	
	[self.mapView setRegion:region animated:YES];
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

#pragma mark -
#pragma mark MKMapView delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation
{
	static NSString *reuseIdentifier = @"annotationView";
	MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
	
	if (!annotationView)
		annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
											 reuseIdentifier:reuseIdentifier];
	
	[annotationView setImage:[UIImage imageNamed:@"pub.png"]];
	
	if (!self.navigateToDetailMap)
	{
		annotationView.enabled = YES;
		annotationView.canShowCallout = YES;
	
		UIButton *callOut = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[callOut addTarget:self action:@selector(showDetailForPlace:) forControlEvents:UIControlEventTouchUpInside];
	
		annotationView.rightCalloutAccessoryView = callOut;
	}
	
	
	return annotationView;
}

#pragma mark storyboard methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([@"showDetailFromMap" isEqualToString:[segue identifier]])
	{
		CLADetailViewController *detailVC = (CLADetailViewController *)[segue destinationViewController];
		
		[detailVC setPlace:_placeToShowDetail];
	}
}

#pragma mark -
#pragma mark helper methods

-(void)showDetailForPlace:(id)sender
{
	_placeToShowDetail =  (CLAPlace *)[[self.mapView selectedAnnotations]lastObject];
	
	[self performSegueWithIdentifier:@"showDetailFromMap" sender:self];
}

-(MKMapView *)mapView
{
	return (MKMapView *)self.view;
}

-(void)setRegion:(MKCoordinateRegion)region
{
	[self.mapView setRegion:region];
}

//needed only to sample some data
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
