//
//  EditPhotoViewController.h
//  JuicedUpPhotoBooth
//
//  Created by Administrator on 9/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Canvas;
@class Smudge;
@class CanvasView;
@class CanvasView;
@interface EditPhotoViewController : UIViewController

{
	IBOutlet UILabel * textEffectValue;
	IBOutlet UIImageView * viewGuidline;
	IBOutlet UISlider * sliderEffectValue;
	IBOutlet UISegmentedControl * segBodyPart;
	IBOutlet UIView * viewRed;
	
	int nEffectArmValue;
	int nEffectForearmsValue;
	int nEffectShouldersValue;
	int nEffectTricepsValue;
	
	CanvasView  *mCanvasView;
}

@property (nonatomic, assign) CGPoint ptLeftArmPoint;
@property (nonatomic, assign) CGPoint ptLeftForearmPoint;
@property (nonatomic, assign) CGPoint ptLeftShoulderPoint;
@property (nonatomic, assign) CGPoint ptLeftTricepPoint;
@property (nonatomic, assign) CGPoint ptRightArmPoint;
@property (nonatomic, assign) CGPoint ptRightForearmPoint;
@property (nonatomic, assign) CGPoint ptRightShoulderPoint;
@property (nonatomic, assign) CGPoint ptRightTricepPoint;

@end
