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
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
	return  [self.store.places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CLAMainTableViewCell";

    CLAMainTableViewCell *cell = (CLAMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier
																						 forIndexPath:indexPath];
	
	CLAPlace *place			= [self.store.places objectAtIndex:indexPath.row];
	
	cell.backgroundColor	= [UIColor clearColor];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
