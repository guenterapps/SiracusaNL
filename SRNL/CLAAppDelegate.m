//
//  CLAAppDelegate.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAAppDelegate.h"
#import <MapKit/MapKit.h>

@interface CLAAppDelegate ()

-(MKCoordinateRegion)regionForDictionary:(NSDictionary *)dict;
-(void)setupViewControllers;

@end

@implementation CLAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

	self.store = [[CLAPlaceStore alloc] init];
	
	[self.store preloadData];
	
	[self setupViewControllers];
	
	[self.window makeKeyAndVisible];
	
	[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bigmenubck"] forBarMetrics:UIBarMetricsDefault];
	[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
	
    return YES;
}

-(void)setupViewControllers
{
	NSDictionary *coordinates = [[NSDictionary alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"DefaultMapZone" withExtension:nil]];
	
	NSDictionary *italia = [[NSDictionary alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"italia" withExtension:nil]];
	
	self.italia = [self regionForDictionary:italia];
	
	//we manually load the storyboard to setup the view controllers
	//we made the vc's semi-singleton to mantain data and have a better user experience
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
	
	self.window.rootViewController	= [storyBoard instantiateInitialViewController];
	
	self.placesTableViewController	= [(UINavigationController *)self.window.rootViewController viewControllers][0];

	self.mapViewController			= [storyBoard instantiateViewControllerWithIdentifier:@"mapViewController"];
	
	[self.mapViewController setRegion:[self regionForDictionary:coordinates]];
	
	self.placesTableViewController.store	= self.store;
	self.mapViewController.store			= self.store;
	

}


-(MKCoordinateRegion)regionForDictionary:(NSDictionary *)dict
{
	MKCoordinateSpan span = MKCoordinateSpanMake([[dict objectForKey:@"latitudeDelta"] floatValue], [[dict objectForKey:@"longitudeDelta"] floatValue]);
	
	CLLocationCoordinate2D center = CLLocationCoordinate2DMake([[dict objectForKey:@"latitude"] floatValue], [[dict objectForKey:@"longitude"] floatValue]);
	
	return MKCoordinateRegionMake(center, span);
}




- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
