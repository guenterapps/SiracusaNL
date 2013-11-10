//
//  CLAPlacesTableViewController.m
//  SRNL
//
//  Created by Christian Lao on 09/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLAPlacesTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CLAMainTableViewCell.h"
#import "CLAMapViewController.h"
#import "CLAAppDelegate.h"
#import "CLADetailViewController.h"

@interface CLAPlacesTableViewController ()

@end

@implementation CLAPlacesTableViewController

-(void)awakeFromNib
{
	UIImage *pin = [UIImage imageNamed:@"iconmap"];
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 52, 46)];
	
	[button setImage:pin forState:UIControlStateNormal];
	[button setContentMode:UIViewContentModeCenter];
	[button addTarget:self action:@selector(toggleMap:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	
	[self.navigationItem setRightBarButtonItem:buttonItem];
}

#pragma mark -
#pragma mark view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	UIImage *backgroundImage = [UIImage imageNamed:@"background-nologo"];
	
	self.tableView.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
}

-(void)viewWillAppear:(BOOL)animated
{
	//we mantain a vc local cache of the data
	if (!self.places)
		self.places = self.store.places;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([@"pushDetailViewController" isEqualToString:[segue identifier]])
	{
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		
		[(CLADetailViewController *)[segue destinationViewController] setPlace:self.store.places[indexPath.row]];
		
	}
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return  [self.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CLAMainTableViewCell";

    CLAMainTableViewCell *cell = (CLAMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier
																						 forIndexPath:indexPath];
	
	CLAPlace *place			= [self.places objectAtIndex:indexPath.row];
	
	UIImageView *fading = [[UIImageView alloc] initWithFrame:cell.bounds];
	[fading setImage:[UIImage imageNamed:@"black_gradient"]];
	
	cell.backgroundColor	= [UIColor clearColor];
	
	[cell.placeImage addSubview:fading];
	[cell setImage:[place image]];
	[cell setName:[place title]];
	
    
    return cell;
}


#pragma mark -
#pragma mark Core methods

-(void)toggleMap:(id)sender
{
	CLAAppDelegate *appDelegate	= (CLAAppDelegate *)[UIApplication sharedApplication].delegate;
	
	CLAMapViewController *mapViewController = appDelegate.mapViewController;

	UINavigationController *navController = self.navigationController;
	
	mapViewController.view.frame = self.view.frame;

	[UIView transitionFromView:self.view toView:mapViewController.view
					  duration:0.30
					   options:UIViewAnimationOptionTransitionFlipFromRight
					completion:^(BOOL finished)
					{
						//[mapViewController.view removeFromSuperview];
						[navController setViewControllers:@[mapViewController]];

					}];
	
}


@end
