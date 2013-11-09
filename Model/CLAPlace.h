//
//  CLAPlace.h
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLAPlaceProtocol.h"
#import <CoreLocation/CoreLocation.h>

@interface CLAPlace : NSObject <CLAPlace>
{
	UIImage *_image;
	NSString *_title;
	NSString *_subTitle;
	CLLocationCoordinate2D _coordinate;
}


@end
