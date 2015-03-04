//
//  ShareController.m
//  ChrismasBubble
//
//  Created by Kim SongIl on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShareController.h"
#import <QuartzCore/QuartzCore.h>
#import <Accounts/Accounts.h>
#import "AppDelegate.h"


@interface ShareController ()

- (void)postPhotoOnTwitter;
- (void)publishPhotoOnFacebook;

@end

@implementation ShareController

@synthesize roundBorderView;
@synthesize descriptionView;
@synthesize thumbView;
@synthesize characterLabel;
@synthesize topBarImage;
@synthesize shareMode;
@synthesize characterBG;
@synthesize sharePhoto;
@synthesize backColor;
@synthesize backImage;
@synthesize shareText;
@synthesize textArchiveText;

- (id)initWithMode:(int)mode {

    self = [super init];
    if (self) {
        shareMode = mode;
        
        if (shareMode == SHARE_FACEBOOK) {
            
            _permissions =  [[NSArray arrayWithObjects:
                              @"read_stream", @"publish_stream", @"offline_access",nil] retain];
            _facebook = [[Facebook alloc] initWithAppId:kFACE_BOOK_APPID
                                            andDelegate:self];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([defaults objectForKey:@"FBAccessTokenKey"] 
                && [defaults objectForKey:@"FBExpirationDateKey"]) {
                _facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
                _facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
                
            }
        }
        else {
            _twitter = [[TwitterLoginViewController alloc] init];
			_twitter.delegate = self;
        }
        
//        shareDlg = [[ShareDialog alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//        sendingProgressController = [[SendingProgressController alloc] init];
//        [sendingProgressController view];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void) dealloc {

//    [sendingProgressController release];
//    [shareDlg release];
    
    [_twitter release];
    [_facebook release];
    [_permissions release];
    
    [characterBG release];
    [topBarImage release];
    [roundBorderView release];
    [descriptionView release];
    [thumbView release];
    [characterLabel release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.roundBorderView.layer.cornerRadius = 10;
    
    if (shareMode == SHARE_FACEBOOK) {
        topBarImage.image = [UIImage imageNamed:@"barFacebook"];
        characterBG.hidden = YES;
        characterLabel.hidden = YES;
		
		textLogout.hidden = YES;
		textLoginDescription.hidden = YES;
		buttonLogout.hidden = YES;
    }
    else {
        topBarImage.image = [UIImage imageNamed:@"barTwitter"];
        characterLabel.text = @"110";
		
		textLogout.hidden = NO;
		textLoginDescription.hidden = NO;
		buttonLogout.hidden = NO;
		
		NSString* username = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitter_username"];
		textLoginDescription.text = [NSString stringWithFormat:@"%@ has been login.", username];
    }
    
    thumbView.transform = CGAffineTransformMakeRotation(-5 * M_PI / 180);
    thumbView.image = self.sharePhoto;
    thumbView.layer.shadowOffset = CGSizeMake(3, 3);
    thumbView.layer.shadowColor = [[UIColor blackColor] CGColor];
    thumbView.layer.shadowOpacity = 1.0;
	
//	backImage.image = nil;
//	backImage.backgroundColor = backColor;
    
    [descriptionView becomeFirstResponder];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidAppear:(BOOL)animated {

	textArchiveText.text = shareText;
    if (shareMode == SHARE_FACEBOOK) {

        if (![_facebook isSessionValid]) {
            [descriptionView resignFirstResponder];
            [_facebook authorize:_permissions];
            return;
        }
    }
    else {
        if (![_twitter isAuthorized]) {
            [descriptionView resignFirstResponder];
            [_twitter authorize];
            return;
        }
    }
}

#pragma mark - 
#pragma mark action handler

- (IBAction)actionCancel:(id)sender {
    
    [descriptionView resignFirstResponder];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)actionShare:(id)sender {
    
    [descriptionView resignFirstResponder];
    
    if ([descriptionView.text length] == 0) {

        UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Message is empty!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alerView show];
        [alerView release];
        
        return;
    }
    
    if (shareMode == SHARE_FACEBOOK) {
        
        if (![_facebook isSessionValid]) {
            [descriptionView resignFirstResponder];
            [_facebook authorize:_permissions];
            return;
        }
        [self publishPhotoOnFacebook];
    }
    else {
        if (![_twitter isAuthorized]) {
            [descriptionView resignFirstResponder];
            [_twitter authorize];
            return;
        }
        [self postPhotoOnTwitter];
    }

//    GBMAppDelegate* appDelegate = (GBMAppDelegate*)[[UIApplication sharedApplication] delegate];
//    [self.navigationController pushViewController:sendingProgressController animated:YES];

//    [self dismissModalViewControllerAnimated:NO];
}


////////facebook
/**
 * Make a Graph API Call to get information about the current logged in user.
 */
- (IBAction)getUserInfo:(id)sender {
	
	[_facebook requestWithGraphPath:@"me" andDelegate:self];
	
}


/**
 * Make a REST API call to get a user's name using FQL.
 */
- (IBAction)getPublicInfo:(id)sender {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"SELECT uid,name FROM user WHERE uid=4", @"query",
                                    nil];
    [_facebook requestWithMethodName:@"fql.query"
                           andParams:params
                       andHttpMethod:@"POST"
                         andDelegate:self];
}

/**
 * Open an inline dialog that allows the logged in user to publish a story to his or
 * her wall.
 */
- (IBAction)publishStream:(id)sender {
    
    SBJSON *jsonWriter = [[SBJSON new] autorelease];
    NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           @"Always Running",@"text",@"http://itsti.me/",@"href", nil], nil];
    
    NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
    NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"a long run", @"name",
                                @"The Facebook Running app", @"caption",
                                @"it is fun", @"description",
                                @"http://itsti.me/", @"href", nil];
    NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Share on Facebook",  @"user_message_prompt",
                                   actionLinksStr, @"action_links",
                                   attachmentStr, @"attachment",
                                   nil];
    
    [_facebook dialog:@"feed" andParams:params andDelegate:self];
}

/**
 * Upload a photo.
 */
- (void)publishPhotoOnFacebook {
    
	NSString * sCaption = [NSString stringWithFormat:@"%@ %@", shareText, descriptionView.text];
	sCaption = [sCaption stringByReplacingOccurrencesOfString:@"%" withString:@"%%"];
	
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   thumbView.image, @"picture",
								   sCaption, @"caption", nil];
    
//	[messageView showInView:self.view];
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
	
	[_facebook requestWithGraphPath:@"me/photos"
                          andParams:params
                      andHttpMethod:@"POST"
                        andDelegate:self];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 return YES;
 }
 
 */

/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {
	
	UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Successfully logged in." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alerView show];
	[alerView release];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[_facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[_facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [descriptionView becomeFirstResponder];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
	
	UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Did not login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alerView show];
	[alerView release];
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}


////////////////////////////////////////////////////////////////////////////////
// FBDialogDelegate

/**
 * Called when a UIServer Dialog successfully return.
 */
- (void)dialogDidComplete:(FBDialog *)dialog {
    
	UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Publish Successfully." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alerView show];
	[alerView release];
}

// Log out

-(IBAction)clickLogout:(id)sender
{
	[_twitter logout];
}

//////////////Twitter////////
- (void)postPhotoOnTwitter1 {
	

	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
	
	NSString* username = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitter_username"];
	NSString* password = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitter_password"];
	
    NSLog(@"username = %@  password = %@", username, password);
    
    UIImage* image =  thumbView.image;//[[ShareData instance] imageForShare];    
	
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.twitpic.com/1/upload.%@", @"1"]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
//    [request addPostValue:@"f74e8b5d2ed596c0d1622fd789b189cc" forKey:@"key"];
    [request addPostValue:@"2lyaNHzo45PdxS5dlOyug" forKey:@"consumer_token"];
//    [request addPostValue:@"yAXxG6hBnX0GOVG213x2P7PiGt6ZvsN8uuxLQpvfw" forKey:@"consumer_secret"];
//    [request addPostValue:@"443350413-MfLuly21cabIzWlgobiXRFTY0t8KsbLPGaWGc9qV" forKey:@"oauth_token"];
//    [request addPostValue:@"e3m8qb2x90M1DjarK9F43bxD0S7rcmuD20gQr02F5z4"forKey:@"oauth_secret"];
    [request addPostValue:descriptionView.text forKey:@"message"];
    [request addData:UIImageJPEGRepresentation(image, 0.8) forKey:@"media"];
    request.requestMethod = @"POST";
    [request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestFailed:)];
    
	[request startAsynchronous];
	
}

//- (IBAction)sendCustomTweet:(id)sender {
- (void)postPhotoOnTwitter {
    // Create an account store object.
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	
    // Create an account type that ensures Twitter accounts are retrieved.
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
	
    // Request access from the user to use their Twitter accounts.
    [accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
        if(granted) {
            // Get the list of Twitter accounts.
            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
			
			
            if ([accountsArray count] > 0) {
                // Grab the initial Twitter account to tweet from.
                ACAccount *twitterAccount = [accountsArray objectAtIndex:0];
				
				
                UIImage *image = thumbView.image;//[UIImage imageNamed:@"Icon.png"];
								
//				shareText = [shareText stringByReplacingOccurrencesOfString:@"%%" withString:@"%%%%"];
				NSString * sStatus = [NSString stringWithFormat:@"%@ %@", shareText, descriptionView.text];
//				[sStatus UTF8String];
				sStatus = [sStatus stringByReplacingOccurrencesOfString:@"%" withString:@"%%"];
				
//				NSLog(@"%@", sStatus);
				
                TWRequest *postRequest = [[TWRequest alloc] initWithURL:[NSURL URLWithString:@"https://upload.twitter.com/1/statuses/update_with_media.json"] 
                                                             parameters:[NSDictionary dictionaryWithObject:sStatus forKey:@"status"] requestMethod:TWRequestMethodPOST];
				
				
				// "http://api.twitter.com/1/statuses/update.json" 
				// update_with_media.json
				
                [postRequest addMultiPartData:UIImagePNGRepresentation(image) withName:@"media" type:@"multipart/png"];
				NSData* dateStatus = [[NSString stringWithFormat:sStatus] dataUsingEncoding:NSUTF8StringEncoding];
				[postRequest addMultiPartData:dateStatus withName:@"status" type:@"text/plain"];
				
                // Set the account used to post the tweet.
                [postRequest setAccount:twitterAccount];
				
                [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                    NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlResponse statusCode]];
//                    [self performSelectorOnMainThread:@selector(displayText:) withObject:output waitUntilDone:NO];
					if ( error == nil  )
					{
					UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
																 message:NSLocalizedString(@"Successfully sent to Twitter." ,@"")
																delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
					msg.tag = 2000;
					[msg show];
					[msg release];
					}
					else {
						UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
																	 message:NSLocalizedString(error.description ,@"")
																	delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
						msg.tag = 2000;
						[msg show];
						[msg release];
					}
					
                }];
            }
        }
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	
	if ([text isEqualToString:@"\n"]) {  
		[textView resignFirstResponder];  
		return NO;
	}

    if (shareMode == SHARE_FACEBOOK) {
        return YES;
    }

	int result = NO;
	NSString* string = [[textView text] stringByReplacingCharactersInRange:range withString:text];
	if ([string length] <= 110) {
		result = YES;
	}
	
	int remainCount = 110 - [string length];
	characterLabel.text = [NSString stringWithFormat:@"%d", (remainCount < 0 ) ? 0 : remainCount]; 
	
	return result;
}

- (void)didLogIn:(TwitterLoginViewController*)controller
{
	NSString* username = [[NSUserDefaults standardUserDefaults] objectForKey:@"twitter_username"];
	textLoginDescription.text = [NSString stringWithFormat:@"%@ has been login.", username];
	
}
- (void)failedLogin:(TwitterLoginViewController*)controller
{
	textLoginDescription.text = @"Please click Share button and login.";
}
- (void)didLogOut:(TwitterLoginViewController*)controller
{
	textLoginDescription.text = @"Please click Share button and login.";
}
- (void)cancelLogin:(TwitterLoginViewController*)controller
{
	textLoginDescription.text = @"Please click Share button and login.";
}

// Facebook request
/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    
    //	[messageView close];
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	
	if ([result isKindOfClass:[NSArray class]]) {
		result = [result objectAtIndex:0];
	}
    
	if ([result objectForKey:@"owner"]) {
        
	}
	else {
        //		[self.label setText:[result objectForKey:@"name"]];
	}
	
	UIAlertView * msgbox = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Successfully sent to Facebook" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	[msgbox show];
	
//    progressView.progress = 1.0;
//	background.image = [UIImage imageNamed:@"bgSent"];
//    [self performSelector:@selector(popup) withObject:nil afterDelay:3.0];
//    [self transitionAnimation];
};

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    
    //	[messageView close];
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
	//	UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:@"Information" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	//	[alerView show];
	//	[alerView release];
    
	UIAlertView * msgbox = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Failed to send to Twitter.\nPlease check internet connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	[msgbox show];
//    background.image = [UIImage imageNamed:@"bgSentFailed"];
//    [self performSelector:@selector(popup) withObject:nil afterDelay:3.0];
//    [self transitionAnimation];
};

// Twitter request
- (void)requestDone:(ASIFormDataRequest*)request {
	
	NSString *response = [request responseString];

	[[UIApplication sharedApplication] endIgnoringInteractionEvents];

	if ([response rangeOfString:@"Invalid twitter username or password"].location != NSNotFound) {
		UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
													 message:NSLocalizedString(@"Invalid twitter username or password." ,@"")
													delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
		[msg show];
		[msg release];
		return;
	}

	UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
												 message:NSLocalizedString(@"Successfully sent to Twitter." ,@"")
												delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
	msg.tag = 2000;
	[msg show];
	[msg release];

}

- (void)requestFailed:(ASIFormDataRequest*)request {
	
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
		UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
													 message:NSLocalizedString(@"Failed to send to Twitter.\nPlease check internet connection." ,@"")
													delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
		[msg show];
		[msg release];
}


@end
