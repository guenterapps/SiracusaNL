//
//  CLAPlaceStore.h
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLAPlace.h"

@interface CLAPlaceStore : NSObject


@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;

@property (nonatomic, readonly) NSArray *places;

-(NSArray *)fetchPlaces;

-(void)preloadData;

@end
