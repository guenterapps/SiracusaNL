//
//  CLAMainTableViewCell.h
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLAMainTableViewCell : UITableViewCell
{
	IBOutlet UILabel *_nameLabel;
	IBOutlet UIImageView *_placeImage;
}

@property (nonatomic) UIImageView *placeImage;

-(void)setName:(NSString *)name;
-(void)setImage:(UIImage *)image;

@end
