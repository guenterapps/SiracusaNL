//
//  CLADetailViewController.h
//  SRNL
//
//  Created by Christian Lao on 10/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CLAPlace.h"


@interface CLADetailViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic) CLAPlace *place;

@property (weak, nonatomic) IBOutlet UIImageView *imageDetail;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImage;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIImageView *emailImage;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;

- (IBAction)sendMail:(id)sender;
- (IBAction)callPhone:(id)sender;

@end
