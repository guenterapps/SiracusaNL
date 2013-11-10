//
//  CLADetailViewController.m
//  SRNL
//
//  Created by Christian Lao on 10/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "CLADetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CLADetailViewController ()

@end

@implementation CLADetailViewController

-(void)awakeFromNib
{
	UIImage *pin = [UIImage imageNamed:@"tab_pin"];
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, pin.size.width, pin.size.height)];
	
	[button setImage:[UIImage imageNamed:@"tab_pin"] forState:UIControlStateNormal];
	//[button addTarget:self action:@selector(toggleMap:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	
	[self.navigationItem setRightBarButtonItem:buttonItem];
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
}


#pragma mark Mail sending methods


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

#pragma mark - Phone call methods

- (IBAction)callPhone:(id)sender
{
	NSURL *phoneNumber = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.place.phoneNumber]];
	
	[[UIApplication sharedApplication] openURL:phoneNumber];
	
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
