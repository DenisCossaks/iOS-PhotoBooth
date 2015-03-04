//
//  EditPhotoViewController.m
//  JuicedUpPhotoBooth
//
//  Created by Administrator on 9/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditPhotoViewController.h"
#import "CanvasView.h"
#import "AppDelegate.h"
#import "FinalViewController.h"

@interface EditPhotoViewController ()

@end

@implementation EditPhotoViewController

@synthesize ptLeftArmPoint, ptRightArmPoint, ptLeftTricepPoint, ptLeftForearmPoint, ptRightTricepPoint, ptLeftShoulderPoint, ptRightForearmPoint, ptRightShoulderPoint;
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
	
	mCanvasView = [[CanvasView alloc] initWithFrame:CGRectMake(0, 44, 320, 375)];
	mCanvasView.image = [[UIImage alloc] initWithCGImage:[AppDelegate getDelegate].ImageWork.CGImage];//[AppDelegate getDelegate].ImageWork;
//	UIImage *imgOrg = [[UIImage alloc] initWithCGImage:[AppDelegate getDelegate].ImageWork.CGImage];
//	[mCanvasView setOriginImage:imgOrg];
	
	viewGuidline.bounds = CGRectMake(0, 0, viewGuidline.image.size.width, viewGuidline.image.size.height);
    viewGuidline.center = self.view.center;
	viewGuidline.transform = [AppDelegate getDelegate].OverlayTransform;
	CGRect rtFrame = viewGuidline.frame;

	ptLeftArmPoint.x = rtFrame.size.width * 0.11f + rtFrame.origin.x; 
	ptLeftArmPoint.y = rtFrame.size.height * 0.34f + rtFrame.origin.y - 44; 
	
	ptLeftShoulderPoint.x = rtFrame.size.width * 0.34f + rtFrame.origin.x; 
	ptLeftShoulderPoint.y = rtFrame.size.height * 0.34f + rtFrame.origin.y - 44; 
	
	ptLeftForearmPoint.x = rtFrame.size.width * 0.20f + rtFrame.origin.x; 
	ptLeftForearmPoint.y = rtFrame.size.height * 0.37f + rtFrame.origin.y - 44; 
	
	ptLeftTricepPoint.x = rtFrame.size.width * 0.22f + rtFrame.origin.x; 
	ptLeftTricepPoint.y = rtFrame.size.height * 0.45f + rtFrame.origin.y - 44; 

	ptRightArmPoint.x = rtFrame.size.width * 0.90f + rtFrame.origin.x; 
	ptRightArmPoint.y = rtFrame.size.height * 0.37f + rtFrame.origin.y - 44; 
	
	ptRightShoulderPoint.x = rtFrame.size.width * 0.66f + rtFrame.origin.x; 
	ptRightShoulderPoint.y = rtFrame.size.height * 0.36f + rtFrame.origin.y - 44; 
	
	ptRightForearmPoint.x = rtFrame.size.width * 0.78f + rtFrame.origin.x; 
	ptRightForearmPoint.y = rtFrame.size.height * 0.39f + rtFrame.origin.y - 44; 
	
	ptRightTricepPoint.x = rtFrame.size.width * 0.73f + rtFrame.origin.x; 
	ptRightTricepPoint.y = rtFrame.size.height * 0.47f + rtFrame.origin.y - 44; 
	
	nEffectArmValue = 0;
	nEffectShouldersValue = 0;
	nEffectForearmsValue = 0;
	nEffectTricepsValue = 0;
	
	mCanvasView.originImage = [AppDelegate getDelegate].ImageWork;
	[mCanvasView initBodyPartPositionWithLeftShoulder:ptLeftShoulderPoint Forearm:ptLeftForearmPoint Arm:ptLeftArmPoint Tricep:ptLeftTricepPoint];
	[mCanvasView initBodyPartPositionWithRightShoulder:ptRightShoulderPoint Forearm:ptRightForearmPoint Arm:ptRightArmPoint Tricep:ptRightTricepPoint];
	
	[self.view addSubview:mCanvasView];
	
	/*
	UIImageView * vwLeftArm = [[UIImageView alloc] initWithFrame:CGRectMake(ptLeftArmPoint.x + rtFrame.origin.x, ptLeftArmPoint.y + rtFrame.origin.y, 10, 10)];
	vwLeftArm.backgroundColor = [UIColor blueColor];
	[self.view addSubview:vwLeftArm];
	UIImageView * vwRightArm = [[UIImageView alloc] initWithFrame:CGRectMake(ptRightArmPoint.x + rtFrame.origin.x, ptRightArmPoint.y + rtFrame.origin.y, 10, 10)];
	vwRightArm.backgroundColor = [UIColor blueColor];
	[self.view addSubview:vwRightArm];
	
	UIImageView * vwLeftForearm = [[UIImageView alloc] initWithFrame:CGRectMake(ptLeftForearmPoint.x + rtFrame.origin.x, ptLeftForearmPoint.y + rtFrame.origin.y, 10, 10)];
	vwLeftForearm.backgroundColor = [UIColor redColor];
	[self.view addSubview:vwLeftForearm];
	UIImageView * vwRightForearm = [[UIImageView alloc] initWithFrame:CGRectMake(ptRightForearmPoint.x + rtFrame.origin.x, ptRightForearmPoint.y + rtFrame.origin.y, 10, 10)];
	vwRightForearm.backgroundColor = [UIColor redColor];
	[self.view addSubview:vwRightForearm];
	
	UIImageView * vwLeftShoulder = [[UIImageView alloc] initWithFrame:CGRectMake(ptLeftShoulderPoint.x + rtFrame.origin.x, ptLeftShoulderPoint.y + rtFrame.origin.y, 10, 10)];
	vwLeftShoulder.backgroundColor = [UIColor blackColor];
	[self.view addSubview:vwLeftShoulder];
	UIImageView * vwRightShoulder = [[UIImageView alloc] initWithFrame:CGRectMake(ptRightShoulderPoint.x + rtFrame.origin.x, ptRightShoulderPoint.y + rtFrame.origin.y, 10, 10)];
	vwRightShoulder.backgroundColor = [UIColor blackColor];
	[self.view addSubview:vwRightShoulder];
	
	UIImageView * vwLeftTricep = [[UIImageView alloc] initWithFrame:CGRectMake(ptLeftTricepPoint.x + rtFrame.origin.x, ptLeftTricepPoint.y + rtFrame.origin.y, 10, 10)];
	vwLeftTricep.backgroundColor = [UIColor purpleColor];
	[self.view addSubview:vwLeftTricep];
	UIImageView * vwRightTricep = [[UIImageView alloc] initWithFrame:CGRectMake(ptRightTricepPoint.x + rtFrame.origin.x, ptRightTricepPoint.y + rtFrame.origin.y, 10, 10)];
	vwRightTricep.backgroundColor = [UIColor purpleColor];
	[self.view addSubview:vwRightTricep];
	*/
	
//	[self.view addSubview:viewGuidline];
}

-(void) getEffectValues
{
	NSInteger segIndex = segBodyPart.selectedSegmentIndex;
	int nValue = 0;
	
	if ( segIndex == 0 ) // shoulder
		nValue = nEffectShouldersValue;
	else if ( segIndex == 1 ) // Forearm
		nValue = nEffectForearmsValue;
	else if ( segIndex == 2 ) // Arm
		nValue = nEffectArmValue;
	else if ( segIndex == 3 ) // Tricep
		nValue = nEffectTricepsValue;
	
	[sliderEffectValue setValue:(float)nValue];
	textEffectValue.text = [NSString stringWithFormat:@"%d", nValue];
}

-(void) showEffectValues
{
	NSInteger segIndex = segBodyPart.selectedSegmentIndex;
	int nValue = (int)sliderEffectValue.value;
	
	if ( segIndex == 0 ) // shoulder
		nEffectShouldersValue = nValue;
	else if ( segIndex == 1 ) // Forearm
		nEffectForearmsValue = nValue;
	else if ( segIndex == 2 ) // Arm
		nEffectArmValue = nValue;
	else if ( segIndex == 3 ) // Tricep
		nEffectTricepsValue = nValue;
	
	textEffectValue.text = [NSString stringWithFormat:@"%d", nValue];
	
	UIImage * orgImage =  [[UIImage alloc] initWithCGImage:[AppDelegate getDelegate].ImageWork.CGImage];
	[mCanvasView setOriginImage:orgImage];
	[mCanvasView applyEffectWithShoulder:nEffectShouldersValue Forearm:nEffectForearmsValue Arm:nEffectArmValue Tricep:nEffectTricepsValue];
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

-(IBAction)clickBack:(id)sender
{
	NSLog(@"click back");
	[self.navigationController popViewControllerAnimated:TRUE];
}

-(IBAction)clickDone:(id)sender
{
	NSLog(@"click done");
	
	AppDelegate * delegate = (AppDelegate *) [AppDelegate getDelegate];
	delegate.ImageWork = mCanvasView.image;
	
	FinalViewController * viewController = [[FinalViewController alloc] initWithNibName:@"FinalViewController" bundle:nil];
	[self.navigationController pushViewController:viewController animated:TRUE];
}

-(IBAction)changeSliderValue:(id)sender
{
	UISlider * slider = (UISlider*) sender;
	NSLog(@"click slider = %d", (int)slider.value);
	
	[self showEffectValues];
}

- (IBAction)segmentSwitch:(id)sender {
	UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
	NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
	
	NSLog(@"segment select = %d", selectedSegment);
	
	[self getEffectValues];
}


@end
