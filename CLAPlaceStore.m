//
//  CLAPlaceStore.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAPlaceStore.h"

@implementation CLAPlaceStore

-(id)init
{
	if (self = [super init])
	{
		UIImage *image = [UIImage imageNamed:@"test.jpg"];
		NSMutableArray *places = [NSMutableArray arrayWithCapacity:15];
		
		for (int i = 0; i < 15; i++)
		{
			CLAPlace *place = [[CLAPlace alloc] init];
			
			[place setTitle:[NSString stringWithFormat:@"place%i", i]];
			[place setImage:image];
			
			
			[places addObject:place];
			
		}
		
		self.places = [NSArray arrayWithArray:places];
	}
	
	
	return self;
}

@end
