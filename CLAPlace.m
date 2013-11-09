//
//  Place.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAPlace.h"


@implementation CLAPlace

@dynamic title;
@dynamic type;
@dynamic phoneNumber;
@dynamic email;
@dynamic subtitle;
@dynamic coordinate;
@dynamic latitude;
@dynamic longitude;
@dynamic descText;
@dynamic image;
@dynamic imageData;


-(void)awakeFromFetch
{
	[super awakeFromFetch];
	
	//[self setImage:[UIImage imageWithData:self.imageData]];
	
}

-(CLLocationCoordinate2D)coordinate
{
	double latitude		= [[self latitude] doubleValue];
	double longitude	= [[self longitude] doubleValue];
	
	return CLLocationCoordinate2DMake(latitude, longitude);
}

-(void)setCoordinate:(CLLocationCoordinate2D)coordinate
{
	[self willChangeValueForKey:@"coordinate"];
	
	[self setPrimitiveValue:[NSNumber numberWithDouble:coordinate.longitude] forKey:@"longitude"];
	[self setPrimitiveValue:[NSNumber numberWithDouble:coordinate.latitude] forKey:@"latitude"];
	
	[self didChangeValueForKey:@"coordinate"];
}

-(UIImage *)image
{
	return [UIImage imageWithData:self.imageData];
}

-(void)setImage:(UIImage *)image
{
	[self willChangeValueForKey:@"image"];
	
	NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
	
	[self setPrimitiveValue:data forKey:@"imageData"];
	
	[self didChangeValueForKey:@"image"];
}


@end
