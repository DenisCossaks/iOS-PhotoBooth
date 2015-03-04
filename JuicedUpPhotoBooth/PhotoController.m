//
//  MainAppController.m
//  MolandPhotoApp
//
//  Created by Ifrit on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainAppController.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "TemplateGalleryController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ShareViewController.h"
#import "LARSAdController.h"

CGImageRef UIGetScreenImage(void);
UIPopoverController *popoverController;
UITextView* textView;
BOOL previewStatus;

@interface MainAppController()
- (BOOL) setTransformApplyWidthX:(float)x widthY:(float)y withScale:(float)scale withRotate:(float)rotation;
@end

@implementation MainAppController

@synthesize photoView;
@synthesize mainPhoto;
@synthesize boundView;
@synthesize pinchGestureRecognizer;
@synthesize rotationGestureRecognizer;
@synthesize templateView;
@synthesize btnLoadPic;
@synthesize btnResize;
@synthesize btnLoadMsg;
@synthesize btnRotate;
@synthesize btnBw;
@synthesize btnEdit;
@synthesize btnUndo;
@synthesize btnSave;
@synthesize btnPreview;
@synthesize btnHome;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.photoView.image = self.mainPhoto;
    
    self.title = @"Crop Photo";
    
    photoView.bounds = CGRectMake(0, 0, photoView.image.size.width, photoView.image.size.height);
    photoView.center = self.view.center;
    previewStatus = false;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];

    float rate_x = photoView.image.size.width / GRID_WIDTH;
    float rate_y = photoView.image.size.width / GRID_HEIGHT;
    
    transition_x  =  transition_y = delta_x = delta_y = 0;
    delta_scale = 0.0f;
    delta_rotate = 0;
    scale = 1 / MAX(rate_x, rate_y);
    [self setTransformApplyWidthX:transition_x + delta_x widthY:transition_y + delta_y withScale:scale withRotate:rotate];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [[LARSAdController sharedManager] addAdContainerToView:self.view withParentViewController:self];
    [[LARSAdController sharedManager] setShouldHandleOrientationChanges:YES];
    
    [btnPreview setHidden:NO];
    [btnHome setHidden:NO];
    [btnLoadPic setHidden:NO];
    [btnResize setHidden:NO];
    [btnLoadMsg setHidden:NO];
    [btnRotate setHidden:NO];
    [btnBw setHidden:NO];
    [btnEdit setHidden:NO];
    [btnUndo setHidden:NO];
    [btnSave setHidden:NO];
    [self.navigationController setNavigationBarHidden:YES];

    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    self.templateView.image = delegate.curTemp;
}

- (void) dealloc {
    
    [boundView release];
    [photoView release];
    [mainPhoto release];
    [pinchGestureRecognizer release];
    [rotationGestureRecognizer release];
    
    [super dealloc];
}

#pragma mark-
#pragma mark Image Processing Module
- (UIImage *) convertToGreyscale:(UIImage *)i {
    
    int kRed = 1;
    int kGreen = 2;
    int kBlue = 4;
    
    int colors = kGreen;
    int m_width = i.size.width;
    int m_height = i.size.height;
    
    uint32_t *rgbImage = (uint32_t *) malloc(m_width * m_height * sizeof(uint32_t));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImage, m_width, m_height, 8, m_width * 4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, m_width, m_height), [i CGImage]);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // now convert to grayscale
    uint8_t *m_imageData = (uint8_t *) malloc(m_width * m_height);
    for(int y = 0; y < m_height; y++) {
        for(int x = 0; x < m_width; x++) {
            uint32_t rgbPixel=rgbImage[y*m_width+x];
            uint32_t sum=0,count=0;
            if (colors & kRed) {sum += (rgbPixel>>24)&255; count++;}
            if (colors & kGreen) {sum += (rgbPixel>>16)&255; count++;}
            if (colors & kBlue) {sum += (rgbPixel>>8)&255; count++;}
            m_imageData[y*m_width+x]=sum/count;
        }
    }
    free(rgbImage);
    
    // convert from a gray scale image back into a UIImage
    uint8_t *result = (uint8_t *) calloc(m_width * m_height *sizeof(uint32_t), 1);
    
    // process the image back to rgb
    for(int i = 0; i < m_height * m_width; i++) {
        result[i*4]=0;
        int val=m_imageData[i];
        result[i*4+1]=val;
        result[i*4+2]=val;
        result[i*4+3]=val;
    }
    
    // create a UIImage
    colorSpace = CGColorSpaceCreateDeviceRGB();
    context = CGBitmapContextCreate(result, m_width, m_height, 8, m_width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);      CGColorSpaceRelease(colorSpace);
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    
    free(m_imageData);
    
    // make sure the data will be released by giving it to an autoreleased NSData
    [NSData dataWithBytesNoCopy:result length:m_width * m_height];
    
    return resultUIImage;
}

-(void) setTemplateImage:(UIImage*)temp
{
    //    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];    
    //    self.templateView.image = delegate.curTemp;
    self.templateView.image = temp;
}

-(IBAction)loadmag:(id)sender
{
    [self.view removeGestureRecognizer:self.pinchGestureRecognizer];
    [self.view removeGestureRecognizer:self.rotationGestureRecognizer];
    
    TemplateGalleryController *detail = [[TemplateGalleryController alloc] initWithNibName:@"TemplateGalleryController" bundle:nil];
    detail.MainDelegate = self;    
    [self.view addSubview:detail.view];
}

-(IBAction)resize:(id)sender
{
    [self.view removeGestureRecognizer:self.rotationGestureRecognizer];
    self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:self.pinchGestureRecognizer];
//    [self.pinchGestureRecognizer release];
}

-(IBAction)rotate:(id)sender
{
    [self.view removeGestureRecognizer:self.pinchGestureRecognizer];
    self.rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:self.rotationGestureRecognizer];
//    [self.rotationGestureRecognizer release];
}

-(IBAction)grey:(id)sender
{
    [self.view removeGestureRecognizer:self.pinchGestureRecognizer];
    [self.view removeGestureRecognizer:self.rotationGestureRecognizer];
    
    UIImage *greyImage =  [self convertToGreyscale:photoView.image];
    photoView.image = greyImage;
}

-(IBAction)loadpic:(id)sender
{
    [self.view removeGestureRecognizer:self.pinchGestureRecognizer];
    [self.view removeGestureRecognizer:self.rotationGestureRecognizer];
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentModalViewController:imagePicker
                                animated:YES];
        //        [imagePicker release];
    }
}

-(IBAction)edittext:(id)sender
{
    [self.view removeGestureRecognizer:self.pinchGestureRecognizer];
    [self.view removeGestureRecognizer:self.rotationGestureRecognizer];
    
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onClickToAddText:)];
    [self.view addGestureRecognizer:panGesture];
    [panGesture release];
}

-(IBAction)undo:(id)sender
{
    [self.view removeGestureRecognizer:self.pinchGestureRecognizer];
    [self.view removeGestureRecognizer:self.rotationGestureRecognizer];
    photoView.image = self.mainPhoto;
    
//    [UIView beginAnimations:@"suck" context:NULL];
//    [UIView setAnimationTransition:103 forView:self.photoView cache:NO];
//    [UIView setAnimationDuration:1.5f];
//    [UIView setAnimationPosition:CGPointMake(btnUndo.frame.origin.x + btnUndo.frame.size.width, btnUndo.frame.origin.y + btnUndo.frame.size.height)];    
//    [UIView commitAnimations];
    
}

-(IBAction)save:(id)sender
{
    [btnPreview setHidden:YES];
    [btnHome setHidden:YES];
    [btnLoadPic setHidden:YES];
    [btnResize setHidden:YES];
    [btnLoadMsg setHidden:YES];
    [btnRotate setHidden:YES];
    [btnBw setHidden:YES];
    [btnEdit setHidden:YES];
    [btnUndo setHidden:YES];
    [btnSave setHidden:YES];
    
    [self.view removeGestureRecognizer:self.pinchGestureRecognizer];
    [self.view removeGestureRecognizer:self.rotationGestureRecognizer];
    [LARSAdController sharedManager].iAdVisible = NO;
    [[LARSAdController sharedManager].iAdBannerView setHidden:YES];
    
    //Merging two UIImages module
//    UIImage *bottomImage = photoView.image;
//    UIImage *image = templateView.image;
//    
//    CGSize newSize = CGSizeMake(photoView.frame.size.width, photoView.frame.size.height);
//    UIGraphicsBeginImageContext( newSize );
//    // Use existing opacity as is
//    [bottomImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    // Apply supplied opacity
//    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height) blendMode:kCGBlendModeNormal alpha:0.8];
//    
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    [delegate.imageSet addObject:newImage];      
//    UIGraphicsEndImageContext();
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
									 target:self
								   selector:@selector(screenCapture:)
								   userInfo:nil
									repeats:NO];
    //Saving image as file module
//    NSString *filename = @"/video_thumb.JPG";
//    //            NSLog(@"filename==%@", filename);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSString *jpgPath = [path stringByAppendingPathComponent:filename];                  
//    [UIImageJPEGRepresentation(prevImg.image, 90) writeToFile:jpgPath atomically:YES];
//    NSURL *fileThumb = [NSURL fileURLWithPath:jpgPath];

}

-(IBAction)screenCapture:(id)sender
{
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //Screen capturing module
    CGImageRef screen = UIGetScreenImage();
    UIImage* measuredImage = [[UIImage imageWithCGImage:screen] retain];
    [delegate.imageSet addObject:measuredImage];        
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:delegate.imageSet forKey:@"STORE"];
    [defaults synchronize];
    
    [measuredImage release];
    CGImageRelease(screen);

    UIImageWriteToSavedPhotosAlbum(measuredImage, nil, nil, nil);
    
    ShareViewController *detail = [[ShareViewController alloc] initWithNibName:@"ShareViewController" bundle:nil];
    detail.shareImage = measuredImage;
    [self.navigationController pushViewController:detail animated:YES];
}

-(IBAction)preview:(id)sender
{
    if(previewStatus == FALSE)
    {
        [btnLoadPic setHidden:YES];
        [btnResize setHidden:YES];
        
        [btnLoadMsg setHidden:YES];
        [btnRotate setHidden:YES];
        [btnBw setHidden:YES];
        
        [btnEdit setHidden:YES];
        [btnUndo setHidden:YES];
        [btnSave setHidden:YES];
        previewStatus = YES;
    }
    else {
        [btnLoadPic setHidden:NO];
        [btnResize setHidden:NO];
        
        [btnLoadMsg setHidden:NO];
        [btnRotate setHidden:NO];
        [btnBw setHidden:NO];
        
        [btnEdit setHidden:NO];
        [btnUndo setHidden:NO];
        [btnSave setHidden:NO];
        previewStatus = NO;
    }
    
}

-(IBAction)home:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Moland" message:@"Do you really want to go to the home screen? Your current work will not be saved." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void) handleRotation:(UIRotationGestureRecognizer *)recognizer 
{
    static float prev_delta_rotation = 0.0f;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        delta_rotate = 0.0f;
        prev_delta_rotation = 0.0f;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        delta_rotate = recognizer.rotation;
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        delta_rotate = recognizer.rotation;
    }
    BOOL result = [self setTransformApplyWidthX:transition_x widthY:transition_y withScale:scale withRotate:rotate + delta_rotate];
    
    if (result)
        prev_delta_rotation = delta_rotate;
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        rotate += prev_delta_rotation;
        prev_delta_rotation = delta_rotate = 0;
    }
}   

- (void) handlePinch:(UIPinchGestureRecognizer *) recognizer
{
    static float prev_delta_scale = 1.0f;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        delta_scale = 1.0f;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        delta_scale = recognizer.scale;
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        delta_scale = recognizer.scale;
    }
    
    BOOL result = [self setTransformApplyWidthX:transition_x widthY:transition_y withScale:scale * delta_scale withRotate:rotate];
    if (result)
        prev_delta_scale = delta_scale;
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        scale *= prev_delta_scale;
        prev_delta_scale = delta_scale = 1.0;
    }
}

- (void) onClickToAddText:(UIPanGestureRecognizer *)recognizer
{
//    static float prev_delta_x = 0.0f, prev_delta_y = 0.0f;
    
    CGPoint currentPoint = [recognizer locationInView:self.view];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        startPosition = currentPoint;
        delta_x = delta_y = 0;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        delta_x = currentPoint.x - startPosition.x;
        delta_y = currentPoint.y - startPosition.y;
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        textView = [[UITextView alloc] initWithFrame:CGRectMake(startPosition.x, startPosition.y, currentPoint.x - startPosition.x, currentPoint.y - startPosition.y)];
        textView.delegate = self;
        [textView setFont:[UIFont systemFontOfSize:40]];
        [textView setTextColor:[UIColor redColor]];
        [textView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:textView];
        [textView release];

        [textView becomeFirstResponder];
    }
    
//    BOOL result = [self setTransformApplyWidthX:transition_x + delta_x widthY:transition_y + delta_y withScale:scale withRotate:rotate];
//    
//    if (result) {
//        prev_delta_x = delta_x;
//        prev_delta_y = delta_y;
//    }
//    
//    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        transition_x += prev_delta_x;
//        transition_y += prev_delta_y;
//        
//        prev_delta_x = prev_delta_y = delta_x = delta_y = 0;
//    }
}

- (BOOL) setTransformApplyWidthX:(float)x widthY:(float)y withScale:(float)scale_ withRotate:(float)rotation {
    
    //    NSLog(@"x = %f, y = %f, scale = %f, roatate = %f", x, y, scale_, rotate);
    
    //	CGAffineTransform tx = CGAffineTransformTranslate(CGAffineTransformIdentity, x * cos(rotation), x * sin(rotation));
    //    CGAffineTransform t = CGAffineTransformTranslate(tx, -y * sin(rotation), y * cos(rotation));    
    photoView.transform = CGAffineTransformIdentity;
    photoView.transform = CGAffineTransformMakeTranslation(-160, -230);
    
    //    NSLog(@"frame = %@", NSStringFromCGRect(imageView.frame));
    
    CGAffineTransform t = CGAffineTransformMakeTranslation(x, y);
    CGAffineTransform s = CGAffineTransformMakeScale(scale_, scale_);
    CGAffineTransform r = CGAffineTransformMakeRotation(rotation);
    
    CGAffineTransform temp1 = CGAffineTransformConcat(photoView.transform, r);
    CGAffineTransform temp2 = CGAffineTransformConcat(temp1, s);
    CGAffineTransform temp3 = CGAffineTransformConcat(temp2, t);
    
    photoView.transform = CGAffineTransformTranslate(temp3, 160, 230);
    
    return YES;
}


- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event { 
    if (textView){ 
        if ([textView canResignFirstResponder]) [textView resignFirstResponder]; 
    
        }
    [super touchesBegan: touches withEvent: event]; 
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	
	if ([text isEqualToString:@"\n"]) {  
		[textView resignFirstResponder];  
		return NO;
	}
    
    int result = NO;
	NSString* string = [[textView text] stringByReplacingCharactersInRange:range withString:text];
	if ([string length] <= 110) {
		result = YES;
	}
	
//	int remainCount = 110 - [string length];
//	characterLabel.text = [NSString stringWithFormat:@"%d", (remainCount < 0 ) ? 0 : remainCount]; 
	
	return result;
}

#pragma mark -
#pragma mark AlertView Delegate
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 0)
    {
        NSLog(@"Cancelled!");
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];        
    }

}

#pragma mark -
#pragma mark UIIimagePickerController

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	UIAlertView *alert;
	
	// Unable to save the image  
	if (error)
		alert = [[UIAlertView alloc] initWithTitle:@"Error" 
										   message:@"Unable to save image to Photo Album." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];
	else // All is well
		alert = [[UIAlertView alloc] initWithTitle:@"Success" 
										   message:@"Image saved to Photo Album." 
										  delegate:self cancelButtonTitle:@"Ok" 
								 otherButtonTitles:nil];	
	[alert show];
	[alert release];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.photoView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [popoverController dismissPopoverAnimated:true];
//    [popoverController release];   
    [self dismissModalViewControllerAnimated:YES];
}

@end
