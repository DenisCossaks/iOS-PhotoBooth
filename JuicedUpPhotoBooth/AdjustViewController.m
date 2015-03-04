//
//  AdjustViewController.m
//  JuicedUpPhotoBooth
//
//  Created by Administrator on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AdjustViewController.h"
#import "AppDelegate.h"
#import "FinalViewController.h"
#import "EditPhotoViewController.h"

@interface AdjustViewController ()

@end

@implementation AdjustViewController

@synthesize imageOrignal, imageTemplate, pinchGestureRecognizer, rotationGestureRecognizer, panGestureRecognizer;

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
	
	AppDelegate * delegate = (AppDelegate *) [AppDelegate getDelegate];
	imageOrignal.image = delegate.ImageWork;
	
	if ( delegate.CurrentMode == 0 )
		imageTemplate.image = [UIImage imageNamed:@"up_guide_line.png"];
	else
		imageTemplate.image = [UIImage imageNamed:@"down_guide_line.png"];
		
	imageTemplate.bounds = CGRectMake(0, 0, imageTemplate.image.size.width, imageTemplate.image.size.height);
    imageTemplate.center = self.view.center;

//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
	
    float rate_x = imageTemplate.image.size.width / 320;
    float rate_y = imageTemplate.image.size.width / 375;
    
    transition_x  =  transition_y = delta_x = delta_y = 0;
    delta_scale = 0.0f;
    delta_rotate = 0;
    scale = 1 / MAX(rate_x, rate_y);
    [self setTransformApplyWidthX:transition_x + delta_x widthY:transition_y + delta_y withScale:scale withRotate:rotate];
}

-(IBAction)move:(id)sender
{
    [self.view removeGestureRecognizer:self.panGestureRecognizer];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMove:)];
	[self.panGestureRecognizer setMinimumNumberOfTouches:1];
    [self.panGestureRecognizer setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:self.panGestureRecognizer];
	
	nEditType = 0;
	
	UIButton* btnMove = (UIButton*) [self.view viewWithTag:100];
	UIButton* btnRotate = (UIButton*) [self.view viewWithTag:200];
	UIButton* btnScale = (UIButton*) [self.view viewWithTag:300];
	
	[btnMove setSelected:TRUE];
	[btnRotate setSelected:FALSE];
	[btnScale setSelected:FALSE];
}

-(IBAction)done:(id)sender
{
	AppDelegate * delegate = (AppDelegate *) [AppDelegate getDelegate];
	delegate.OverlayTransform = imageTemplate.transform;
	
//	FinalViewController * viewController = [[FinalViewController alloc] initWithNibName:@"FinalViewController" bundle:nil];
//	[self.navigationController pushViewController:viewController animated:TRUE];
	
	EditPhotoViewController * viewController = [[EditPhotoViewController alloc] initWithNibName:@"EditPhotoViewController" bundle:nil];
	[self.navigationController pushViewController:viewController animated:TRUE];
	
}

-(IBAction)resize:(id)sender
{
    [self.view removeGestureRecognizer:self.rotationGestureRecognizer];
    self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:self.pinchGestureRecognizer];
	//    [self.pinchGestureRecognizer release];
	nEditType = 1;
	
	UIButton* btnMove = (UIButton*) [self.view viewWithTag:100];
	UIButton* btnRotate = (UIButton*) [self.view viewWithTag:200];
	UIButton* btnScale = (UIButton*) [self.view viewWithTag:300];
	
	[btnMove setSelected:FALSE];
	[btnRotate setSelected:FALSE];
	[btnScale setSelected:TRUE];
}

-(IBAction)rotate:(id)sender
{
    [self.view removeGestureRecognizer:self.pinchGestureRecognizer];
    self.rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:self.rotationGestureRecognizer];
	//    [self.rotationGestureRecognizer release];
	nEditType = 2;
	
	UIButton* btnMove = (UIButton*) [self.view viewWithTag:100];
	UIButton* btnRotate = (UIButton*) [self.view viewWithTag:200];
	UIButton* btnScale = (UIButton*) [self.view viewWithTag:300];
	
	[btnMove setSelected:FALSE];
	[btnRotate setSelected:TRUE];
	[btnScale setSelected:FALSE];
}

- (BOOL) setTransformApplyWidthX:(float)x widthY:(float)y withScale:(float)scale_ withRotate:(float)rotation {
    
    //    NSLog(@"x = %f, y = %f, scale = %f, roatate = %f", x, y, scale_, rotate);
    
    //	CGAffineTransform tx = CGAffineTransformTranslate(CGAffineTransformIdentity, x * cos(rotation), x * sin(rotation));
    //    CGAffineTransform t = CGAffineTransformTranslate(tx, -y * sin(rotation), y * cos(rotation));    
    imageTemplate.transform = CGAffineTransformIdentity;
    imageTemplate.transform = CGAffineTransformMakeTranslation(-160, -230);
    
    //    NSLog(@"frame = %@", NSStringFromCGRect(imageView.frame));
    
    CGAffineTransform t = CGAffineTransformMakeTranslation(x, y);
    CGAffineTransform s = CGAffineTransformMakeScale(scale_, scale_);
    CGAffineTransform r = CGAffineTransformMakeRotation(rotation);
    
    CGAffineTransform temp1 = CGAffineTransformConcat(imageTemplate.transform, r);
    CGAffineTransform temp2 = CGAffineTransformConcat(temp1, s);
    CGAffineTransform temp3 = CGAffineTransformConcat(temp2, t);
    
    imageTemplate.transform = CGAffineTransformTranslate(temp3, 160, 230);
    
    return YES;
}

- (void) handleMove:(UIPanGestureRecognizer *) recognizer
{
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)recognizer translationInView:self.view];
	
	if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan) {
//		delta_x = [imageTemplate center].x;
//		delta_y = [imageTemplate center].y;
	}
	
	translatedPoint = CGPointMake(delta_x+translatedPoint.x, delta_x+translatedPoint.y);
	transition_x = translatedPoint.x;
	transition_y = translatedPoint.y;
	
	[self setTransformApplyWidthX:transition_x widthY:transition_y withScale:scale withRotate:rotate + delta_rotate];
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

-(void) dealloc
{
	[super dealloc];
}

@end
