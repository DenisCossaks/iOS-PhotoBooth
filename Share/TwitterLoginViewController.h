//
//  TwitterLoginViewController.h
//  ChrismasBubble
//
//  Created by Kim SongIl on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterLoginViewController;
@protocol TwitterLoginViewControllerDelegate <NSObject>
- (void)didLogIn:(TwitterLoginViewController*)controller;
- (void)failedLogin:(TwitterLoginViewController*)controller;
- (void)didLogOut:(TwitterLoginViewController*)controller;
- (void)cancelLogin:(TwitterLoginViewController*)controller;
@end

@interface TwitterLoginViewController : UIViewController <UITextFieldDelegate> {
    
    UIActivityIndicatorView* activity;
    UITextField* userName;
	UITextField* password;
    UIScrollView* contentView;
    
    id<TwitterLoginViewControllerDelegate>delegate;
}

@property(nonatomic, retain) IBOutlet UIActivityIndicatorView* activity;
@property(nonatomic, retain) IBOutlet UITextField* userName;
@property(nonatomic, retain) IBOutlet UITextField* password;
@property(nonatomic, retain) IBOutlet UIScrollView* contentView;
@property(nonatomic, assign) id<TwitterLoginViewControllerDelegate> delegate;

- (IBAction)logInTwitter:(id)sender;
- (IBAction)cancel:(id)sender;
- (BOOL)isAuthorized;
- (void)authorize;
- (void)logout;

@end
