//
//  FinalViewController.m
//  JuicedUpPhotoBooth
//
//  Created by Administrator on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FinalViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "ShareController.h"

@interface FinalViewController ()

@end

@implementation FinalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)onRejuice:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:TRUE];
}

-(IBAction)onSaveToLib:(id)sender
{
	UIButton * btnHome = (UIButton *) [self.view viewWithTag:100];
	UIButton * btnFacebook = (UIButton *) [self.view viewWithTag:200];
	UIButton * btnTwitter = (UIButton *) [self.view viewWithTag:300];
	UIButton * btnSave = (UIButton *) [self.view viewWithTag:400];
	UIImageView * viewToolbar = (UIImageView *) [self.view viewWithTag:500];
	
	btnHome.hidden = YES;
	btnFacebook.hidden = YES;
	btnTwitter.hidden = YES;
	btnSave.hidden = YES;
	viewToolbar.hidden = YES;
	
	
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
		UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
	else
		UIGraphicsBeginImageContext(self.view.bounds.size);
	
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	UIImageWriteToSavedPhotosAlbum(finalImage, nil, @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), nil);
	
	btnHome.hidden = NO;
	btnFacebook.hidden = NO;
	btnTwitter.hidden = NO;
	btnSave.hidden = NO;
	viewToolbar.hidden = NO;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *) contextInfo;
{
	if ( error )
	{
		UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Juiced Up Photo Booth" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
	}
	else
	{
		UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Juiced Up Photo Booth" message:@"Save image completed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
	}
}

-(IBAction)onShareToFacebook:(id)sender
{
	
	UIButton * btnHome = (UIButton *) [self.view viewWithTag:100];
	UIButton * btnFacebook = (UIButton *) [self.view viewWithTag:200];
	UIButton * btnTwitter = (UIButton *) [self.view viewWithTag:300];
	UIButton * btnSave = (UIButton *) [self.view viewWithTag:400];
	UIImageView * viewToolbar = (UIImageView *) [self.view viewWithTag:500];
	
	btnHome.hidden = YES;
	btnFacebook.hidden = YES;
	btnTwitter.hidden = YES;
	btnSave.hidden = YES;
	viewToolbar.hidden = YES;
	
	
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
		UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
	else
		UIGraphicsBeginImageContext(self.view.bounds.size);
	
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
//	UIImageWriteToSavedPhotosAlbum(finalImage, nil, @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), nil);
	
	btnHome.hidden = NO;
	btnFacebook.hidden = NO;
	btnTwitter.hidden = NO;
	btnSave.hidden = NO;
	viewToolbar.hidden = NO;
	
	ShareController* facebook = [[ShareController alloc] initWithMode:SHARE_FACEBOOK];	
	facebook.sharePhoto = finalImage;
//	facebook.backColor = g_newGoalInfo.GoalBackColor;
	
	NSString * sShareText = [NSString stringWithFormat:@"Hi, I'm using the Juiced Up Photo Booth app and got my strong photo today - "];
	facebook.shareText = sShareText;
	
    [self presentModalViewController:facebook animated:YES];
    [facebook release];

}

-(IBAction)onShareToTwitter:(id)sender
{
	UIButton * btnHome = (UIButton *) [self.view viewWithTag:100];
	UIButton * btnFacebook = (UIButton *) [self.view viewWithTag:200];
	UIButton * btnTwitter = (UIButton *) [self.view viewWithTag:300];
	UIButton * btnSave = (UIButton *) [self.view viewWithTag:400];
	UIImageView * viewToolbar = (UIImageView *) [self.view viewWithTag:500];
	
	btnHome.hidden = YES;
	btnFacebook.hidden = YES;
	btnTwitter.hidden = YES;
	btnSave.hidden = YES;
	viewToolbar.hidden = YES;
	
	
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
		UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
	else
		UIGraphicsBeginImageContext(self.view.bounds.size);
	
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
//	UIImageWriteToSavedPhotosAlbum(finalImage, nil, @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), nil);
	
	btnHome.hidden = NO;
	btnFacebook.hidden = NO;
	btnTwitter.hidden = NO;
	btnSave.hidden = NO;
	viewToolbar.hidden = NO;
	
    ShareController* twitter = [[ShareController alloc] initWithMode:SHARE_TWITTER];
	twitter.sharePhoto = finalImage;
//	twitter.backColor = g_newGoalInfo.GoalBackColor;
	
	NSString * sShareText = [NSString stringWithFormat:@"Hi, I'm using the Juiced Up Photo Booth app and got my strong photo today - "];
	twitter.shareText = sShareText;
	
    [self presentModalViewController:twitter animated:YES];
    [twitter release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	AppDelegate * delegate = (AppDelegate *) [AppDelegate getDelegate];
	imageFinalPhoto.image = delegate.ImageWork;
	
	if ( delegate.CurrentMode == 0 )
		imageOverlay.image = [UIImage imageNamed:@"up_guide_body.png"];
	else
		imageOverlay.image = [UIImage imageNamed:@"down_guide_body.png"];
	
	imageOverlay.bounds = CGRectMake(0, 0, imageOverlay.image.size.width, imageOverlay.image.size.height);
    imageOverlay.center = self.view.center;
	
	imageOverlay.transform = delegate.OverlayTransform;
	imageOverlay.hidden = YES;
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

@end
