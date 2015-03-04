//
//  CanvasView.m
//  MeshTestVC
//
//  Created by osone on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CanvasView.h"
#import "AppDelegate.h"
//#import "EditPhotoView.h"

#define TOUCH_MODE_SCROLL   @"SCROLL"
#define TOUCH_MODE_RESHAPE   @"RESHAPE"

@implementation CanvasView

@synthesize originImage;
@synthesize brushSize;
@synthesize touchMode;
@synthesize arrayHistory;
@synthesize curHistoryIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.userInteractionEnabled = YES;
        brushSize = 20;
        warper = nil;
        arrayHistory = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) initBodyPartPositionWithLeftShoulder:(CGPoint)ptShoulder Forearm:(CGPoint)ptForearm Arm:(CGPoint)ptArm Tricep:(CGPoint)ptTricep
{
	ptLeftShoulderPoint = ptShoulder;
	ptLeftForearmPoint = ptForearm;
	ptLeftArmPoint = ptArm;
	ptLeftTricepPoint = ptTricep;
}

- (void) initBodyPartPositionWithRightShoulder:(CGPoint)ptShoulder Forearm:(CGPoint)ptForearm Arm:(CGPoint)ptArm Tricep:(CGPoint)ptTricep
{
	ptRightShoulderPoint = ptShoulder;
	ptRightForearmPoint = ptForearm;
	ptRightArmPoint = ptArm;
	ptRightTricepPoint = ptTricep;
	/*
	UIImageView * vwMark = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
	vwMark.backgroundColor = [UIColor yellowColor];
	[self addSubview:vwMark];
	
	UIImageView * vwLeftArm = [[UIImageView alloc] initWithFrame:CGRectMake(ptLeftArmPoint.x, ptLeftArmPoint.y, 10, 10)];
	vwLeftArm.backgroundColor = [UIColor blueColor];
	[self addSubview:vwLeftArm];
	UIImageView * vwRightArm = [[UIImageView alloc] initWithFrame:CGRectMake(ptRightArmPoint.x, ptRightArmPoint.y, 10, 10)];
	vwRightArm.backgroundColor = [UIColor blueColor];
	[self addSubview:vwRightArm];
	
	UIImageView * vwLeftForearm = [[UIImageView alloc] initWithFrame:CGRectMake(ptLeftForearmPoint.x, ptLeftForearmPoint.y , 10, 10)];
	vwLeftForearm.backgroundColor = [UIColor redColor];
	[self addSubview:vwLeftForearm];
	UIImageView * vwRightForearm = [[UIImageView alloc] initWithFrame:CGRectMake(ptRightForearmPoint.x, ptRightForearmPoint.y, 10, 10)];
	vwRightForearm.backgroundColor = [UIColor redColor];
	[self addSubview:vwRightForearm];
	
	UIImageView * vwLeftShoulder = [[UIImageView alloc] initWithFrame:CGRectMake(ptLeftShoulderPoint.x , ptLeftShoulderPoint.y, 10, 10)];
	vwLeftShoulder.backgroundColor = [UIColor blackColor];
	[self addSubview:vwLeftShoulder];
	UIImageView * vwRightShoulder = [[UIImageView alloc] initWithFrame:CGRectMake(ptRightShoulderPoint.x, ptRightShoulderPoint.y, 10, 10)];
	vwRightShoulder.backgroundColor = [UIColor blackColor];
	[self addSubview:vwRightShoulder];
	
	UIImageView * vwLeftTricep = [[UIImageView alloc] initWithFrame:CGRectMake(ptLeftTricepPoint.x, ptLeftTricepPoint.y, 10, 10)];
	vwLeftTricep.backgroundColor = [UIColor purpleColor];
	[self addSubview:vwLeftTricep];
	UIImageView * vwRightTricep = [[UIImageView alloc] initWithFrame:CGRectMake(ptRightTricepPoint.x, ptRightTricepPoint.y, 10, 10)];
	vwRightTricep.backgroundColor = [UIColor purpleColor];
	[self addSubview:vwRightTricep];
*/
}

- (void) applyEffectWithShoulder:(int)eShoulder Forearm:(int)eForearm Arm:(int)eArm Tricep:(int)eTricep
{
//	self.image = originImage;
	
	// --- Apply left Arm effect
	if ( ptLeftArmPoint.x > 0 && ptLeftArmPoint.y > 0 )
	{
		ImageWarper::Point pt;
		pt.X = ptLeftArmPoint.x / 2 * scale.x;
		pt.Y = ptLeftArmPoint.y * scale.y;
		
		for ( int i = 0; i < eArm; i ++ )
		{
			warper->BeginWarp(pt, 10 * scale.x, 1);
			
			warpedImage = warper->UpdateWarp(pt);
			warper->EndWarp(warpedImage);
		}
	}
	
	// --- Apply left Shoulder effect
	if ( ptLeftShoulderPoint.x > 0 && ptLeftShoulderPoint.y > 0 )
	{
		ImageWarper::Point pt;
		pt.X = ptLeftShoulderPoint.x / 2 * scale.x;
		pt.Y = ptLeftShoulderPoint.y * scale.y;
		
		for ( int i = 0; i < eShoulder; i ++ )
		{
			warper->BeginWarp(pt, 10 * scale.x, 1);
			
			warpedImage = warper->UpdateWarp(pt);
			warper->EndWarp(warpedImage);
		}
	}
	
	// --- Apply left Forearm effect
	if ( ptLeftForearmPoint.x > 0 && ptLeftForearmPoint.y > 0 )
	{
		ImageWarper::Point pt;
		pt.X = ptLeftForearmPoint.x / 2 * scale.x;
		pt.Y = ptLeftForearmPoint.y * scale.y;
		
		for ( int i = 0; i < eForearm; i ++ )
		{
			warper->BeginWarp(pt, 10 * scale.x, 1);
			
			warpedImage = warper->UpdateWarp(pt);
			warper->EndWarp(warpedImage);
		}
	}
	
	// --- Apply left Tricep effect
	if ( ptLeftTricepPoint.x > 0 && ptLeftTricepPoint.y > 0 )
	{
		ImageWarper::Point pt;
		pt.X = ptLeftTricepPoint.x / 2 * scale.x;
		pt.Y = ptLeftTricepPoint.y * scale.y;
		
		for ( int i = 0; i < eTricep; i ++ )
		{
			warper->BeginWarp(pt, 20 * scale.x, 0);
			
			ImageWarper::Point pt1;
			pt1.X = pt.X - 15;
			pt1.Y = pt.Y + 30;
			warpedImage = warper->UpdateWarp(pt1);
			warper->EndWarp(warpedImage);
		}
	}
	
	// --- Apply Right Arm effect
	if ( ptRightArmPoint.x > 0 && ptRightArmPoint.y > 0 )
	{
		ImageWarper::Point pt;
		pt.X = ptRightArmPoint.x / 2 * scale.x;
		pt.Y = ptRightArmPoint.y * scale.y;
		
		for ( int i = 0; i < eArm; i ++ )
		{
			warper->BeginWarp(pt, 10 * scale.x, 1);
			
			warpedImage = warper->UpdateWarp(pt);
			warper->EndWarp(warpedImage);
		}
	}
	
	// --- Apply Right Shoulder effect
	if ( ptRightShoulderPoint.x > 0 && ptRightShoulderPoint.y > 0 )
	{
		ImageWarper::Point pt;
		pt.X = ptRightShoulderPoint.x / 2 * scale.x;
		pt.Y = ptRightShoulderPoint.y * scale.y;
		
		for ( int i = 0; i < eShoulder; i ++ )
		{
			warper->BeginWarp(pt, 10 * scale.x, 1);
			
			warpedImage = warper->UpdateWarp(pt);
			warper->EndWarp(warpedImage);
		}
	}
	
	// --- Apply right Forearm effect
	if ( ptRightForearmPoint.x > 0 && ptRightForearmPoint.y > 0 )
	{
		ImageWarper::Point pt;
		pt.X = ptRightForearmPoint.x / 2 * scale.x;
		pt.Y = ptRightForearmPoint.y * scale.y;
		
		for ( int i = 0; i < eForearm; i ++ )
		{
			warper->BeginWarp(pt, 10 * scale.x, 1);
			
			warpedImage = warper->UpdateWarp(pt);
			warper->EndWarp(warpedImage);
		}
	}
	
	// --- Apply right Tricep effect
	if ( ptRightTricepPoint.x > 0 && ptRightTricepPoint.y > 0 )
	{
		ImageWarper::Point pt;
		pt.X = ptRightTricepPoint.x / 2 * scale.x;
		pt.Y = ptRightTricepPoint.y * scale.y;
		
		for ( int i = 0; i < eTricep; i ++ )
		{
			warper->BeginWarp(pt, 20 * scale.x, 0);
			
			ImageWarper::Point pt1;
			pt1.X = pt.X + 15;
			pt1.Y = pt.Y + 30;
			warpedImage = warper->UpdateWarp(pt1);
			warper->EndWarp(warpedImage);

		}
	}
	
	
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGContextRef resultContext = CGBitmapContextCreate(warper->getOriginalImage()->Data,
													   warper->getOriginalImage()->Width, 
													   warper->getOriginalImage()->Height, 
													   8,
													   warper->getOriginalImage()->ScanWidth, 
													   colorspace, 
													   kCGImageAlphaPremultipliedFirst);
	
	CGImageRef imageRef = CGBitmapContextCreateImage(resultContext);
	UIImage* result_image = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	CGColorSpaceRelease(colorspace);
	CGContextRelease(resultContext);
	self.image = result_image;
	 
	/*
	ImageWarper::Point pt;
	pt.X = 100.0f;
	pt.Y = 100.0f;
	ptFirst = pt;
	warper->BeginWarp(pt, 20, 1);
	
	ImageWarper::Point pt1;
	pt1.X = 100.0f;
	pt1.Y = 100.0f;
	warpedImage = warper->UpdateWarp(pt1);
	warper->EndWarp(warpedImage);
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGContextRef resultContext = CGBitmapContextCreate(warper->getOriginalImage()->Data,
													   warper->getOriginalImage()->Width, 
													   warper->getOriginalImage()->Height, 
													   8,
													   warper->getOriginalImage()->ScanWidth, 
													   colorspace, 
													   kCGImageAlphaPremultipliedFirst);
	
	CGImageRef imageRef = CGBitmapContextCreateImage(resultContext);
	UIImage* result_image = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef);
	CGColorSpaceRelease(colorspace);
	CGContextRelease(resultContext);
	self.image = result_image;
*/
}

- (void) setHistoryImage:(NSMutableArray *)arrayHistory_
{
    if (arrayHistory != arrayHistory_) {
        [arrayHistory release];
        arrayHistory = [arrayHistory_ retain];
        [arrayHistory release];
        arrayHistory = [arrayHistory_ retain];
        //[mCanvas setImage:originImage context:&context];
    }
}

- (void) setTouchMode:(NSString *)touchMode_
{
    if (touchMode != touchMode_) {
        [touchMode release];
        touchMode = [touchMode_ retain];
        [touchMode release];
        touchMode = [touchMode_ retain];
        //[mCanvas setImage:originImage context:&context];
    }
}

- (void) setOriginImage:(UIImage *)originImage_
{
    if (originImage_ != originImage) {
        [originImage release];
        originImage = [originImage_ retain];
        //[mCanvas setImage:originImage context:&context];

//        NSData* orgImageData = UIImageJPEGRepresentation(originImage, 1.0);
        
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        originMaskBuffer = (UInt8*) malloc(originImage.size.width * originImage.size.height * 4);

        CGContextRef maskContext = CGBitmapContextCreate(originMaskBuffer, 
                                                         originImage.size.width, 
                                                         originImage.size.height, 
                                                         8,
                                                         originImage.size.width*4, 
                                                         colorspace, 
                                                         kCGImageAlphaNoneSkipFirst);
        
        NSLog(@"Image width = %f, height = %f", originImage.size.width, originImage.size.height);
        CGContextDrawImage(maskContext, CGRectMake(0, 0, originImage.size.width, originImage.size.height), originImage.CGImage);

        imgData = new ImageData(originImage.size.width, originImage.size.height, originImage.size.width * 4, 8);
        memcpy(imgData->Data, (char*)(void*)originMaskBuffer, originImage.size.width * 4 * originImage.size.height);
        
//        ImageData imgData1;
//        imgData1.Resize(originImage.size.width, originImage.size.height, 3, originImage.size.width * 3);
//        memcpy(imgData1.Data, (char*)(void*)originMaskBuffer, originImage.size.width * 3 * originImage.size.height);
//        imgData->Data = originMaskBuffer;
        if (warper != nil) {
            delete warper;
        }

        warper = new Warper(imgData);

//        ImageWarper::Point pt;
//        pt.X = 10;
//        pt.Y = 10;
//        warper->BeginWarp(pt, 40, WARPER_TRANSLATE);
//        
//        for (int i = 14; i < 80; i = i + 5) {
//            pt.X = i;
//            pt.Y = i;
//            warpedImage = warper->UpdateWarp(pt);
//        }
//        warpedImage = warper->EndWarp(warpedImage);


//        CGContextRef resultContext = CGBitmapContextCreate(warpedImage->Image.Data,
//                                                           warpedImage->Image.Width, 
//                                                           warpedImage->Image.Height, 
//                                                           8,
//                                                           warpedImage->Image.ScanWidth, 
//                                                           colorspace, 
//                                                           kCGImageAlphaNone);

//        imgData = warper->getOriginalImage();

        scale.x = originImage.size.width / self.frame.size.width;
        scale.y = originImage.size.height / self.frame.size.height;

        CGContextRef resultContext = CGBitmapContextCreate(imgData->Data,
                                                           imgData->Width, 
                                                           imgData->Height, 
                                                           8,
                                                           imgData->ScanWidth, 
                                                           colorspace, 
                                                           kCGImageAlphaPremultipliedFirst);
        CGImageRef imageRef = CGBitmapContextCreateImage(resultContext);
        UIImage* result_image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        CGColorSpaceRelease(colorspace);
        CGContextRelease(resultContext);
        self.image = result_image;
        
        bClicked = false;

    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
//    [AppDelegate sharedAppDelegate].editPhotoView.scrollView.alpha = 1.0;
//    [[AppDelegate sharedAppDelegate].editPhotoView.viewInfo1 setHidden:YES];
//    [[AppDelegate sharedAppDelegate].editPhotoView.viewInfo2 setHidden:YES];
//    [[AppDelegate sharedAppDelegate].editPhotoView.viewInfo3 setHidden:YES];
//    [[AppDelegate sharedAppDelegate].editPhotoView.viewInfo4 setHidden:YES];
    
    if (bClicked == true) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    touchedPoint = [touch locationInView:self];
	NSLog(@"touched = %f, %f", touchedPoint.x, touchedPoint.y);
    
    CGPoint eventLocation;
    if ([touchMode isEqualToString:TOUCH_MODE_SCROLL])
        return;
    for (UITouch *touch in touches) {
        
        
        eventLocation = [touch locationInView:touch.view];
//
//        NSData* orgImageData = UIImageJPEGRepresentation(originImage, 1.0);
//        
//        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
//        originMaskBuffer = (UInt8*) malloc(originImage.size.width * originImage.size.height * 4);
//        CGContextRef maskContext = CGBitmapContextCreate(originMaskBuffer, 
//                                                         originImage.size.width, 
//                                                         originImage.size.height, 
//                                                         8,
//                                                         originImage.size.width*4, 
//                                                         colorspace, 
//                                                         kCGImageAlphaPremultipliedFirst);
//        CGContextDrawImage(maskContext, CGRectMake(0, 0, originImage.size.width, originImage.size.height), originImage.CGImage);
//        CGContextRelease(maskContext);
//        CGColorSpaceRelease(colorspace);
//        imgData = new ImageData(originImage.size.width, originImage.size.height, 0.5, 8);
//        imgData->Data = originMaskBuffer;
//        
//        
//        warper = new Warper(imgData);
        ImageWarper::Point pt;
        pt.X = eventLocation.x / 2 * scale.x;
        pt.Y = eventLocation.y * scale.y;
        ptFirst = pt;
        warper->BeginWarp(pt, brushSize * scale.x, 2);
        bClicked = true;
        
        if (curHistoryIndex < 2)
            curHistoryIndex = 2;
        break;
    }
   
    //    [mSmudge mouseDown:event inView:self onCanvas:mCanvas onCGPoint:&eventLocation];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (bClicked == false) {
        return;
    }
    UITouch *touch = [touches anyObject];
    movedPoint = [touch locationInView:self];
	NSLog(@"moved = %f, %f", movedPoint.x, movedPoint.y);
    
    if ([touchMode isEqualToString:TOUCH_MODE_SCROLL])
        return;
    
    CGPoint eventLocation;
    for (UITouch *touch in touches) {
        eventLocation = [touch locationInView:touch.view];
        
        ImageWarper::Point pt1;
        pt1.X = eventLocation.x / 2 * scale.x;
        pt1.Y = eventLocation.y * scale.y;
        
        if ( (pt1.X - ptFirst.X) * (pt1.X - ptFirst.X) + (pt1.Y - ptFirst.Y) * (pt1.Y - ptFirst.Y) < 50 ) {
            return;
        }

        warpedImage = warper->UpdateWarp(pt1);
        warpedImage = warper->EndWarp(warpedImage);
        warper->BeginWarp(pt1, brushSize, 0);
        ptFirst = pt1;
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        CGContextRef resultContext = CGBitmapContextCreate(warper->getOriginalImage()->Data,
                                                           warper->getOriginalImage()->Width, 
                                                           warper->getOriginalImage()->Height, 
                                                           8,
                                                           warper->getOriginalImage()->ScanWidth, 
                                                           colorspace, 
                                                           kCGImageAlphaPremultipliedFirst);
        
        CGImageRef imageRef = CGBitmapContextCreateImage(resultContext);
        UIImage* result_image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        CGColorSpaceRelease(colorspace);
        CGContextRelease(resultContext);
        self.image = result_image;
        break;
    }
    
    //    [mSmudge mouseDragged:event inView:self onCanvas:mCanvas onCGPoint:&eventLocation];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {


    UITouch *touch = [touches anyObject];
    endedPoint = [touch locationInView:self];
	NSLog(@"ended = %f, %f", endedPoint.x, endedPoint.y);
    if (bClicked == false) {
        return;
    }

    if ([touchMode isEqualToString:TOUCH_MODE_SCROLL])
        return;
    
    CGPoint eventLocation;
    for (UITouch *touch in touches) {
        eventLocation = [touch locationInView:touch.view];

        ImageWarper::Point pt1;
        pt1.X = eventLocation.x / 2 * scale.x;
        pt1.Y = eventLocation.y  * scale.y;
        warpedImage = warper->UpdateWarp(pt1);
        warper->EndWarp(warpedImage);
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        CGContextRef resultContext = CGBitmapContextCreate(warper->getOriginalImage()->Data,
                                                           warper->getOriginalImage()->Width, 
                                                           warper->getOriginalImage()->Height, 
                                                           8,
                                                           warper->getOriginalImage()->ScanWidth, 
                                                           colorspace, 
                                                           kCGImageAlphaPremultipliedFirst);
        
        CGImageRef imageRef = CGBitmapContextCreateImage(resultContext);
        UIImage* result_image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        CGColorSpaceRelease(colorspace);
        CGContextRelease(resultContext);
        self.image = result_image;
        if (arrayHistory.count == 3) {
            [arrayHistory removeObjectAtIndex:0];
        }
        UIImage* img = [result_image copy];
        [arrayHistory addObject:img];
        break;
    }
    bClicked = false;
    //    [mSmudge mouseUp:event inView:self onCanvas:mCanvas onCGPoint:&eventLocation];
}


@end
