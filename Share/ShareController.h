//
//  ShareController.h
//  ChrismasBubble
//
//  Created by Kim SongIl on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "TwitterLoginViewController.h"
#import "SendingProgressController.h"
//#import "ShareDialog.h"
#import <Twitter/Twitter.h>
#import "ASIFormDataRequest.h"

typedef enum _tagShareMode {

    SHARE_TWITTER,
    SHARE_FACEBOOK,
    
} ShareMode;

@interface ShareController : UIViewController
<FBDialogDelegate,
FBSessionDelegate, TwitterLoginViewControllerDelegate, FBRequestDelegate>

{
    UIImage *sharePhoto;
	UIColor * backColor;
    IBOutlet UIView* roundBorderView;
    IBOutlet UITextView* descriptionView;
    IBOutlet UIImageView* thumbView;
    IBOutlet UIImageView* topBarImage;
    IBOutlet UILabel*   characterLabel;
    IBOutlet UIImageView* characterBG;
	IBOutlet UIImageView* backImage;
	
	IBOutlet UILabel * textLoginDescription;
	IBOutlet UILabel * textLogout;
	IBOutlet UIButton * buttonLogout;
    
    TwitterLoginViewController* _twitter;
    Facebook* _facebook;
    NSArray* _permissions;

    ShareMode shareMode;
    
//    ShareDialog* shareDlg;
    SendingProgressController* sendingProgressController;
}

@property (nonatomic, retain) UIImage *sharePhoto;
@property (nonatomic, retain) UIColor *backColor;
@property (nonatomic, retain) NSString *shareText;
@property (nonatomic, retain) UIImageView * backImage;
@property (nonatomic, retain) IBOutlet UIView* roundBorderView;
@property (nonatomic, retain) IBOutlet UITextView* descriptionView;
@property (nonatomic, retain) IBOutlet UIImageView* topBarImage;
@property (nonatomic, retain) IBOutlet UIImageView* thumbView;
@property (nonatomic, retain) IBOutlet UILabel*   characterLabel;
@property (nonatomic, retain) IBOutlet UIImageView* characterBG;
@property (nonatomic, retain) IBOutlet UILabel * textArchiveText;
@property (nonatomic, assign) ShareMode shareMode;


- (id)initWithMode:(int)mode;
- (IBAction)actionCancel:(id)sender;
- (IBAction)actionShare:(id)sender;

- (void)requestDone:(ASIFormDataRequest*)request;
- (void)requestFailed:(ASIFormDataRequest*)request;

@end
