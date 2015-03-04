//
//  CanvasView.h
//  MeshTestVC
//
//  Created by osone on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ManagedWrapper.h"

@interface CanvasView : UIImageView {

    CGPoint touchedPoint;
    CGPoint movedPoint;
    CGPoint endedPoint;
    
    UInt8* originMaskBuffer;
    UInt8* resultMaskBuffer;
    Warper* warper;
    ImageData* imgData;
    WarpedImage* warpedImage;
    bool bClicked;
    ImageWarper::Point ptFirst;
    
    int brushSize;
    
    CGPoint scale;
	
	CGPoint ptLeftArmPoint;
	CGPoint ptLeftForearmPoint;
	CGPoint ptLeftShoulderPoint;
	CGPoint ptLeftTricepPoint;
	CGPoint ptRightArmPoint;
	CGPoint ptRightForearmPoint;
	CGPoint ptRightShoulderPoint;
	CGPoint ptRightTricepPoint;
}

@property (nonatomic, retain) UIImage* originImage;
@property (nonatomic, readwrite) int brushSize;
@property (nonatomic, readwrite) int curHistoryIndex;
@property (nonatomic, strong) NSString* touchMode;
@property (nonatomic, strong) NSMutableArray* arrayHistory;

- (void) initBodyPartPositionWithLeftShoulder:(CGPoint)ptShoulder Forearm:(CGPoint)ptForearm Arm:(CGPoint)ptArm Tricep:(CGPoint)ptTricep;
- (void) initBodyPartPositionWithRightShoulder:(CGPoint)ptShoulder Forearm:(CGPoint)ptForearm Arm:(CGPoint)ptArm Tricep:(CGPoint)ptTricep;
- (void) applyEffectWithShoulder:(int)eShoulder Forearm:(int)eForearm Arm:(int)eArm Tricep:(int)eTricep;

@end
