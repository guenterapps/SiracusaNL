//
//  CLAMainTableViewCell.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#define VERTICAL_INSET 10
#define HORIZONTAL_INSET 7

#import "CLAMainTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CLAMainTableViewCell


-(void)setName:(NSString *)name
{	
	_nameLabel.text = name;

}

-(void)setImage:(UIImage *)image
{
	_placeImage.image = image;
	_placeImage.layer.borderColor = [UIColor whiteColor].CGColor;
	_placeImage.layer.borderWidth = 1.0;
}

-(void)prepareForReuse
{
	_placeImage.image = nil;
	_nameLabel.text = nil;
}

//-(void)layoutSubviews
//{
//	_placeImage.frame = CGRectInset(self.bounds, HORIZONTAL_INSET, VERTICAL_INSET);
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
