//
//  CLADetailViewController.m
//  SRNL
//
//  Created by Christian Lao on 10/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#define MARGIN 5
#define SAWTOOTH_HEIGHT 12

#import "CLADetailViewController.h"
#import "CLAMapViewController.h"
#include "CLAAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface CLADetailViewController ()

@end

@implementation CLADetailViewController

-(void)awakeFromNib
{
	[self setupBackAndDisclosure];
}


-(void)viewDidLoad
{
	[super viewDidLoad];
	
	UIImage *backgroundImage = [UIImage imageNamed:@"background-nologo"];
	
	self.tableView.backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
	
	self.imageDetail.layer.borderColor = [UIColor whiteColor].CGColor;
	self.imageDetail.layer.borderWidth = 1.0;
}


-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	self.navigationItem.title = self.place.title;
	
	self.imageDetail.image = self.place.image;
	
	if (self.place.email && [MFMailComposeViewController canSendMail])
	{
		[self.emailButton setEnabled:YES];
		[self.emailButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		self.emailImage.image = [UIImage imageNamed:@"email"];
	}
	
	if (self.place.phoneNumber)
	{
		[self.phoneButton setEnabled:YES];
		[self.phoneButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		self.phoneImage.image = [UIImage imageNamed:@"phone"];
	}
	
	self.address.text = self.place.subtitle;
	self.distance.text = @"55 km";
	self.descText.text = self.place.descText;
}

#pragma mark StoryBoard methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([@"showMapDetail" isEqualToString:[segue identifier]])
	{
		CLAMapViewController *mapVC = (CLAMapViewController *)[segue destinationViewController];
		
		MKCoordinateRegion italia = [(CLAAppDelegate *)[UIApplication sharedApplication].delegate italia];
		
		[mapVC setPlaces:@[self.place]];
		[mapVC setRegion:italia navigateToDetailMap:YES];
	}
}

#pragma mark Mail & Phone

- (IBAction)sendMail:(id)sender
{
	MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];

	composer.mailComposeDelegate = self;
	
	[composer setToRecipients:@[self.place.email]];
	
	[self presentViewController:composer animated:YES completion:nil];
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)callPhone:(id)sender
{
	NSURL *phoneNumber = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.place.phoneNumber]];
	
	[[UIApplication sharedApplication] openURL:phoneNumber];
	
}

#pragma mark TableView delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	//needed to handle variable height desc text
	
	CGFloat height;
	
	switch (indexPath.row)
	{
		case 0:
			height = 270.0;
			break;
		case 1:
			height = 55.0;
			break;
		case 2:
			height =  (SAWTOOTH_HEIGHT + (2 * MARGIN) + self.descText.contentSize.height);
			break;

	}
	
	return height;
}


#pragma mark custom methods

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		NSString *stringToCopy = [NSString stringWithFormat:@"%@ - @ %@", self.place.title, self.place.subtitle];
		
		[[UIPasteboard generalPasteboard] setString:stringToCopy];
	}
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
