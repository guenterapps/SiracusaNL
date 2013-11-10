//
//  UIViewController+UIViewController_CommonUtilities.m
//  SRNL
//
//  Created by Christian Lao on 10/11/13.
//  Copyright (c) 2013 Christian Lao. All rights reserved.
//

#import "UIViewController+CommonUtilities.h"

@implementation UIViewController (CommonUtilities)

-(void)popViewController:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)setupBackAndDisclosure
{
	UIImage *detail = [UIImage imageNamed:@"detaildisclosure"];
	UIImage *leftArrow = [UIImage imageNamed:@"backbtm"];
	
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 46)];
	UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 46)];
	
	[button setImage:detail forState:UIControlStateNormal];
	[button addTarget:self action:@selector(showSheet:) forControlEvents:UIControlEventTouchUpInside];
	
	[backButton setImage:leftArrow forState:UIControlStateNormal];
	[backButton addTarget:self action:@selector(popViewController:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
	
	[self.navigationItem setLeftBarButtonItem:backItem];
	[self.navigationItem setRightBarButtonItem:buttonItem];
}

-(void)showSheet:(id)sender
{
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
													   delegate:nil
											  cancelButtonTitle:@"Annulla"
										 destructiveButtonTitle:nil
											  otherButtonTitles:@"Copia dettagli", nil];
	
	[sheet setDelegate:(id <UIActionSheetDelegate>)self];
	[sheet showInView:self.view];
	
	
}

@end
