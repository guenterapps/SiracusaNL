//
//  CLAPlace.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAPlace.h"

@implementation CLAPlace


-(NSString *)title
{
	return  [_title copy];
}

-(void)setTitle:(NSString *)title
{
	_title = [title copy];
}

-(void)setSubtitle:(NSString *)subTitle
{
	_subTitle = [subTitle copy];
}

-(NSString *)subtitle
{
	return [_subTitle copy];
}

-(void)setImage:(UIImage *)image
{
	_image = image;
}

-(UIImage *)image
{
	return _image;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
	_coordinate = newCoordinate;
}

-(CLLocationCoordinate2D)coordinate
{
	return _coordinate;
}

@end
