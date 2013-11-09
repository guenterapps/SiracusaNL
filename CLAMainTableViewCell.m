//
//  CLAMainTableViewCell.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAMainTableViewCell.h"

@implementation CLAMainTableViewCell


-(void)setName:(NSString *)name
{	
	_nameLabel.text = name;

}

-(void)setImage:(UIImage *)image
{
	_placeImage.image = image;
	//_placeImage.layer.borderColor = [UIColor whiteColor].CGColor;
	//_placeImage.layer.borderWidth = 2.0;
}

-(void)prepareForReuse
{
	_placeImage.image = nil;
	_nameLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
