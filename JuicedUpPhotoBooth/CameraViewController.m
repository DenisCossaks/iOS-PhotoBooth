//
//  CameraViewController.m
//  JuicedUpPhotoBooth
//
//  Created by Administrator on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraViewController.h"
#import "AppDelegate.h"
#import "AdjustViewController.h"
#import "AppDelegate.h"


@interface CameraViewController ()

@end

@implementation CameraViewController

@synthesize imagePickerController;
@synthesize overlayView, flashButton, switchButton, imageTemplate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
	
	switchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [switchButton setBackgroundImage:[UIImage imageNamed:@"SwitchCam.png"] forState:UIControlStateNormal];
    switchButton.alpha = 0.5;
    switchButton.frame = CGRectMake(250, 10, 55, 25);
    switchButton.clipsToBounds = YES;
//    switchButton.layer.radi = 15;//half of the width
	//    button.layer.borderColor=[UIColor redColor].CGColor;
	//    button.layer.borderWidth=2.0f;
    [switchButton addTarget:self action:@selector(onClickBtnSwitchCam:) forControlEvents:UIControlEventTouchUpInside]; 
//    [overlayView addSubview:switchButton];
	
	flashButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [flashButton setBackgroundImage:[UIImage imageNamed:@"FlashCam.png"] forState:UIControlStateNormal];
    flashButton.alpha = 0.5;    
    flashButton.frame = CGRectMake(10, 10, 55, 25);
    flashButton.clipsToBounds = YES;
//    flashButton.layer.cornerRadius = 15;//half of the width
    [flashButton addTarget:self action:@selector(onClickBtnFlush:) forControlEvents:UIControlEventTouchUpInside]; 
    [overlayView addSubview:flashButton];
	
	if ( [AppDelegate getDelegate].CurrentMode == 0 )
		imageTemplate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up_guide_line.png"]];
	else
		imageTemplate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_guide_line.png"]];
		
    imageTemplate.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH);
    [overlayView addSubview:imageTemplate];
	
	imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
//    [self presentModalViewController:imagePickerController animated:YES];   
    imagePickerController.showsCameraControls=YES;
	imagePickerController.delegate = self;
	[self.view addSubview:imagePickerController.view];
	imagePickerController.view.frame = CGRectMake(0, 0, 320, 460);
	imagePickerController.cameraViewTransform = CGAffineTransformScale(imagePickerController.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
	imagePickerController.cameraOverlayView = overlayView;
	
	isCameraRear = YES;
	isFlash = NO;
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

#pragma UIImagePickerControllerDelegates
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	NSLog(@"user take photo.");
	AppDelegate * delegate = (AppDelegate*) [AppDelegate getDelegate];
	UIImage* img = [image scaleToSize:CGSizeMake(320, 375)];
	delegate.ImageWork = [img scaleAndRotateImage];
	
//	[self.navigationController popViewControllerAnimated:TRUE];
	
//	FinalViewController * viewController = [[FinalViewController alloc] initWithNibName:@"FinalViewController" bundle:nil];
//	[self.navigationController pushViewController:viewController animated:TRUE];
	
	AdjustViewController * viewController = [[AdjustViewController alloc] initWithNibName:@"AdjustViewController" bundle:nil];
	[self.navigationController pushViewController:viewController animated:TRUE];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction) onClickBtnSwitchCam:(id)sender 
{	
    if (isCameraRear == YES) {
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        isCameraRear = NO;
    }   
    else if (isCameraRear == NO) {
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        isCameraRear = YES;
    }   
}

-(IBAction)onClickBtnFlush:(id)sender
{
    if (isFlash == YES) {
        imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        [flashButton setBackgroundImage:[UIImage imageNamed:@"FlashCam.png"] forState:UIControlStateNormal];
        isFlash = NO;
    }   
	else if (isFlash == NO) {        
        imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        [flashButton setBackgroundImage:[UIImage imageNamed:@"FlashCamOn.png"] forState:UIControlStateNormal];
        isFlash = YES;
	}  
}

#pragma Memory Dealloc
- (void) dealloc
{
	[imagePickerController release];
	[flashButton release];
	[switchButton release];
	[overlayView release];
	[imageTemplate release];
	
	[super dealloc];
}

@end
