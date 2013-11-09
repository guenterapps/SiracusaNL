//
//  Place.h
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import "CLAPlaceProtocol.h"


@interface CLAPlace : NSManagedObject <CLAPlace>

@property (nonatomic, copy) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * descText;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) UIImage *image;

@end
