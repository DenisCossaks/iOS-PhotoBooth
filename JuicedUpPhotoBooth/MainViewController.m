//
//  MainViewController.m
//  JuicedUpPhotoBooth
//
//  Created by Administrator on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "CameraViewController.h"
#import "AppDelegate.h"
#import "AdjustViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)onBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:TRUE];
}

-(IBAction)onTemplateUpMode:(id)sender
{
	UIButton * btnUp = (UIButton * )[self.view viewWithTag:100];
	UIButton * btnDown = (UIButton * )[self.view viewWithTag:200];

	[AppDelegate getDelegate].CurrentMode = 0;
	[btnUp setSelected:TRUE];
	[btnDown setSelected:FALSE];

}

-(IBAction)onTemplateDownMode:(id)sender
{
	UIButton * btnUp = (UIButton * )[self.view viewWithTag:100];
	UIButton * btnDown = (UIButton * )[self.view viewWithTag:200];
	
	[AppDelegate getDelegate].CurrentMode = 1;
	[btnUp setSelected:FALSE];
	[btnDown setSelected:TRUE];

}

#pragma mark UIImagePickerControllerDelegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	NSLog(@"user take photo.");
	AppDelegate * delegate = (AppDelegate*) [AppDelegate getDelegate];
	delegate.ImageWork = image;
	
	//	[self.navigationController popViewControllerAnimated:TRUE];
	
	//	FinalViewController * viewController = [[FinalViewController alloc] initWithNibName:@"FinalViewController" bundle:nil];
	//	[self.navigationController pushViewController:viewController animated:TRUE];
	
	[picker dismissModalViewControllerAnimated:YES];
	
	AdjustViewController * viewController = [[AdjustViewController alloc] initWithNibName:@"AdjustViewController" bundle:nil];
	[self.navigationController pushViewController:viewController animated:TRUE];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}


-(IBAction)onCamera:(id)sender
{
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
    {
		UIImagePickerController *controller = [[UIImagePickerController alloc] init];
		controller.allowsEditing = TRUE;
		controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		controller.delegate = self;
		[self.navigationController presentModalViewController:controller animated:YES];
		[controller release];
    }
	else
	{
		CameraViewController * viewCamera = [[CameraViewController alloc] initWithNibName:@"CameraViewController" bundle:nil];
		[self.navigationController pushViewController:viewCamera animated:TRUE];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	UIButton * btnUp = (UIButton * )[self.view viewWithTag:100];
	UIButton * btnDown = (UIButton * )[self.view viewWithTag:200];
	
	if ( [AppDelegate getDelegate].CurrentMode == 0 )
	{
		[btnUp setSelected:TRUE];
		[btnDown setSelected:FALSE];
	}
	else
	{
		[btnUp setSelected:FALSE];
		[btnDown setSelected:TRUE];
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
