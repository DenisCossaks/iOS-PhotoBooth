//
//  AppDelegate.h
//  JuicedUpPhotoBooth
//
//  Created by Administrator on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
	int CurrentMode;
	UIImage * ImageWork; 
	CGAffineTransform  OverlayTransform;
}

@property (nonatomic, assign) int CurrentMode;
@property (nonatomic, retain) UIImage* ImageWork;
@property (nonatomic, assign) CGAffineTransform  OverlayTransform;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

+ (AppDelegate*) getDelegate;

@end
