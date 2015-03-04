//
//  MainAppController.h
//  MolandPhotoApp
//
//  Created by Ifrit on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateGalleryController.h"

@interface MainAppController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,
UIPopoverControllerDelegate, UITextViewDelegate, UIAlertViewDelegate, TemplateGalleryDelegate>

{
    UIImage *mainPhoto;
    IBOutlet UIView* boundView;

    int changedFlag;
    
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
    
    UIPinchGestureRecognizer *pinchGestureRecognizer;
    UIRotationGestureRecognizer *rotationGestureRecognizer;
}

@property (nonatomic, retain) IBOutlet UIImageView *photoView;
@property (nonatomic, retain) IBOutlet UIImageView *templateView;

@property (nonatomic, retain) IBOutlet UIView* boundView;

@property (nonatomic, retain) IBOutlet UIButton *btnLoadPic;
@property (nonatomic, retain) IBOutlet UIButton *btnLoadMsg;
@property (nonatomic, retain) IBOutlet UIButton *btnResize;
@property (nonatomic, retain) IBOutlet UIButton *btnRotate;
@property (nonatomic, retain) IBOutlet UIButton *btnBw;
@property (nonatomic, retain) IBOutlet UIButton *btnEdit;
@property (nonatomic, retain) IBOutlet UIButton *btnUndo;
@property (nonatomic, retain) IBOutlet UIButton *btnSave;
@property (nonatomic, retain) IBOutlet UIButton *btnPreview;
@property (nonatomic, retain) IBOutlet UIButton *btnHome;

@property (nonatomic, retain) UIImage *mainPhoto;
@property (nonatomic, retain) UIPinchGestureRecognizer *pinchGestureRecognizer;
@property (nonatomic, retain) UIRotationGestureRecognizer *rotationGestureRecognizer;

-(IBAction)loadmag:(id)sender;
-(IBAction)resize:(id)sender;
-(IBAction)rotate:(id)sender;
-(IBAction)grey:(id)sender;
-(IBAction)loadpic:(id)sender;
-(IBAction)edittext:(id)sender;
-(IBAction)undo:(id)sender;
-(IBAction)save:(id)sender;

-(IBAction)preview:(id)sender;
-(IBAction)home:(id)sender;

- (UIImage *) convertToGreyscale:(UIImage *)i;
- (void)cropPhoto;

@end
