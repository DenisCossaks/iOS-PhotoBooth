//
//  AdjustViewController.h
//  JuicedUpPhotoBooth
//
//  Created by Administrator on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdjustViewController : UIViewController

{
	IBOutlet UIImageView * imageOrignal;
	IBOutlet UIImageView * imageTemplate;
	
	UIImage * imageMask;
	
	int nEditType;		// 0 : Move, 1 : Scale, 2 : Rotate
	
	int touchState;
    float m_PrevDistance;
    
    float transition_x, transition_y, delta_x, delta_y;
    float scale, delta_scale;
    float rotate, delta_rotate;
    CGPoint p[4];
    float m[4];
    float b[4];
    float a[4];
    
    CGPoint startPosition;
    
	UIPanGestureRecognizer *panGestureRecognizer;
    UIPinchGestureRecognizer *pinchGestureRecognizer;
    UIRotationGestureRecognizer *rotationGestureRecognizer;
}

@property (nonatomic, retain) UIPinchGestureRecognizer *pinchGestureRecognizer;
@property (nonatomic, retain) UIPanGestureRecognizer *panGestureRecognizer;

@property (nonatomic, retain) UIRotationGestureRecognizer *rotationGestureRecognizer;


@property (nonatomic, retain) UIImageView * imageTemplate;
@property (nonatomic, retain) UIImageView * imageOrignal;

@end
