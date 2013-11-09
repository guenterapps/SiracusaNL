//
//  CLAMapViewController.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAMapViewController.h"
#import "CLAAppDelegate.h"

@interface CLAMapViewController ()

@end

@implementation CLAMapViewController

-(void)awakeFromNib
{
	UIImage *pin = [UIImage imageNamed:@"tab_pin"];
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, pin.size.width, pin.size.height)];
	
	[button setImage:[UIImage imageNamed:@"tab_pin"] forState:UIControlStateNormal];
	[button addTarget:self action:@selector(toggleMap:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	
	[self.navigationItem setRightBarButtonItem:buttonItem];
	[self.navigationItem setTitle:@"SIRACUSA NIGHTLIFE"];
}

-(void)toggleMap:(id)sender
{

	CLAAppDelegate *appDelegate				= (CLAAppDelegate *)[UIApplication sharedApplication].delegate;
	
	UINavigationController *navController	= self.navigationController;

	CLAPlacesTableViewController *mainTableViewController = appDelegate.placesTableViewController;
	
	mainTableViewController.view.frame = self.view.frame;
	
	[UIView transitionFromView:self.view toView:mainTableViewController.view
					  duration:0.30
					   options:UIViewAnimationOptionTransitionFlipFromLeft
					completion:^(BOOL finished)
	 {

		[navController setViewControllers:@[mainTableViewController]];
		 
	 }];
	
}


- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
