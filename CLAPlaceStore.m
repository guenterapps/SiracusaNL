//
//  CLAPlaceStore.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAPlaceStore.h"

#define ORTI

@implementation CLAPlaceStore

@synthesize model = _model, coordinator = _coordinator, context = _context, places = _places;


-(NSArray *)places
{
	if (!_places)
		_places = [self fetchPlaces];
	
	return _places;
}

#pragma mark -
#pragma mark Core Data sweetness

-(NSArray *)fetchPlaces
{
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Place"];
	request.fetchBatchSize	= 10;
	
	NSError *error;
	NSArray *resultSet = [self.context executeFetchRequest:request error:&error];
	
	if (!resultSet)
	{
		NSLog(@"%@", error);

		[[[UIAlertView alloc] initWithTitle:[error domain]
									message:[error localizedDescription]
								   delegate:nil
						  cancelButtonTitle:nil
						  otherButtonTitles:nil] show];
	}
		
	return resultSet;
}

-(void)preloadData
{
	NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Place"];
	
	NSError *error;
	
	if ([self.context countForFetchRequest:request error:&error] > 0 || error)
		return;

	
	for (int i = 1; i <= 20; i++)
	{
		CLAPlace *place = [NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.context];

		[place setTitle:[NSString stringWithFormat:@"Baretto %i", i]];
		[place setSubtitle:[NSString stringWithFormat:@"Piazza Duomo %i", i]];
		
		[place setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg", i]]];

		double delta = rand() % 999999;
		
		int sign = (delta - 555555) > 0 ? 1 : -1;
		
		NSString *descText = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
		
		if (sign > 0)
		{
			[place setEmail:@"mail@mail.it"];
			[place setPhoneNumber:@"09318723729"];
			
			place.descText = descText;
		}
		else
		{
			place.descText = [NSString stringWithFormat:@"%@\n%@", descText, descText];
		
		}

		double latitude = 37.060357849187263 + sign * (delta * pow(10, -9));
		double longitude = 15.292802513913557 + sign * (delta * pow(10, -9));

		[place setCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
	}
	
	[self.context save:&error];
	
	if (error)
	{
		NSLog(@"%@", error);
		
		[[[UIAlertView alloc] initWithTitle:[error domain]
									message:[error localizedDescription]
								   delegate:nil
						  cancelButtonTitle:nil
						  otherButtonTitles:nil] show];
	}
}

#pragma mark -
#pragma mark Core Data Stack setup


-(NSManagedObjectContext *)context
{
	if (!_context)
	{
		_context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
		

		[_context setPersistentStoreCoordinator:self.coordinator];
			 
		NSURL * documentDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
																	 inDomains:NSUserDomainMask] lastObject];

		 
		NSURL *storeUrl = [documentDirectory URLByAppendingPathComponent:@"store.sqllite"];
		 
		NSAssert(storeUrl, @"Could not load SQLite file!\n");
		
		NSError *error;
		
		NSPersistentStore *store = [_coordinator addPersistentStoreWithType:NSSQLiteStoreType
															   configuration:nil
																		 URL:storeUrl
																	 options:nil
																	   error:&error];
		if (!store)
		{
			NSLog(@"%@", error);

			[[[UIAlertView alloc] initWithTitle:[error domain]
										message:[error localizedDescription]
									   delegate:nil
							  cancelButtonTitle:nil
							  otherButtonTitles:nil] show];
		}
	}

	return _context;
}

-(NSManagedObjectModel *)model
{
	if (!_model)
	{
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"Model"
														 ofType:@"momd"];
		
		NSURL *modelUrl = [NSURL fileURLWithPath:path];
		
		NSParameterAssert(modelUrl);
		
		_model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
		
		NSAssert(_model, @"could not load model");
	}
	
	return _model;
}

-(NSPersistentStoreCoordinator *)coordinator
{
	if (!_coordinator)
	{
		_coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
		
		NSAssert(_coordinator, @"Could not create NSPersistentStoreCoordinator!\n");
	}
	
	return _coordinator;
}

@end
