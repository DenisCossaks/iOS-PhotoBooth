//
//  CameraViewController.h
//  JuicedUpPhotoBooth
//
//  Created by Administrator on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Scale.h"


// Transform values for full screen support:
#define CAMERA_TRANSFORM_X 1
//#define CAMERA_TRANSFORM_Y 1.12412 // this was for iOS 3.x
#define CAMERA_TRANSFORM_Y 1.24299 // this works for iOS 4.x

// iPhone screen dimensions:
#define SCREEN_WIDTH  320
#define SCREEN_HEIGTH 430

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
	UIImagePickerController * imagePickerController;
	
	UIView * overlayView;
	UIButton * switchButton;
	UIButton * flashButton;
	UIImageView* imageTemplate;
	
	BOOL isCameraRear;
	BOOL isFlash;
}

@property (nonatomic, retain) UIImagePickerController * imagePickerController;
@property (nonatomic, retain) UIView* overlayView;
@property (nonatomic, retain) UIButton * switchButton;
@property (nonatomic, retain) UIButton * flashButton;
@property (nonatomic, retain) UIImageView * imageTemplate;

@end
