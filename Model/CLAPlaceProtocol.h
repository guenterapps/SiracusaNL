//
//  CLAPlaceProtocol.h
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLAPlace <NSObject>

-(UIImage *)image;
-(void)setImage:(UIImage *)image;

-(NSString *)name;
-(void)setName:(NSString *)name;


@end
