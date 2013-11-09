//
//  CLAPlace.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAPlace.h"

@implementation CLAPlace


-(NSString *)name
{
	return  [_name copy];
}

-(void)setName:(NSString *)name
{
	_name = [name copy];
}

-(void)setImage:(UIImage *)image
{
	_image = image;
}

-(UIImage *)image
{
	return _image;
}

@end
