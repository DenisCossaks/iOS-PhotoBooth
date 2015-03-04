//
//  TwitterLoginViewController.m
//  ChrismasBubble
//
//  Created by Kim SongIl on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterLoginViewController.h"
#import "ASIFormDataRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@implementation TwitterLoginViewController

@synthesize userName;
@synthesize password;
@synthesize activity;
@synthesize delegate;
@synthesize contentView;

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

- (void)dealloc {
    
    [userName release];
    [password release];
    [activity release];
    [contentView release];
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.exclusiveTouch = YES;
    contentView.contentSize = CGSizeMake(278, 398);
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


- (void)requestDone:(ASIFormDataRequest*)request {
    
	NSString *response = [request responseString];
 //   NSLog(@"%@", response);
	[activity stopAnimating];
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	
	if ([response rangeOfString:@"Invalid twitter username or password"].location != NSNotFound) {
		UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
													 message:NSLocalizedString(@"Invalid twitter username or password." ,@"")
													delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
		[msg show];
		[msg release];
		return;
	}
	
	int statuscode = [request responseStatusCode];
	NSLog(@"staus = %d \n%@", statuscode, response);
	
	NSUserDefaults* database = [NSUserDefaults standardUserDefaults];
	[database setObject:userName.text forKey:@"twitter_username"];
	[database setObject:password.text forKey:@"twitter_password"];
	[database synchronize];
    
    if (delegate && [delegate respondsToSelector:@selector(didLogIn:)]) {
        [delegate didLogIn:self];
    }

    [self.view removeFromSuperview];
    CATransition* animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.2;
	AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [[[appDelegate window] layer] addAnimation:animation forKey:nil];
}

- (void)requestFailed:(ASIFormDataRequest*)request {
	
    NSUserDefaults* database = [NSUserDefaults standardUserDefaults];
    [database removeObjectForKey:@"twitter_username"];
    [database removeObjectForKey:@"twitter_password"];
    [database synchronize];

	[activity stopAnimating];
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
	
	UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
												 message:NSLocalizedString(@"Failed to send to Twitter.\nPlease check internet connection." ,@"")
												delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
	[msg show];
	[msg release];
    
    if (delegate && [delegate respondsToSelector:@selector(failedLogin:)]) {
        [delegate failedLogin:self];
    }
}

- (IBAction)logInTwitter:(id)sender {
	
	if ([userName.text length] == 0) {
		UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
													 message:NSLocalizedString(@"User name is empty.\nPlease enter again." ,@"")
													delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
		[msg show];
		[msg release];
		return;
	}
	
	if ([password.text length] == 0) {
		UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
													 message:NSLocalizedString(@"Password is empty.\nPlease enter again." ,@"")
													delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
		[msg show];
		[msg release];
		return;
	}
	
	[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
	[activity startAnimating];
	
    [userName resignFirstResponder];
    [password resignFirstResponder];
    self.contentView.frame = CGRectMake(21, 53, 278, 398);
    [contentView setContentOffset:CGPointMake(0, 0) animated:YES];

	NSURL *twitpicURL = [NSURL URLWithString:@"http://api.twitpic.com/api/uploadAndPost"];
	ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:twitpicURL] autorelease];
	[request setPostValue:userName.text forKey:@"username"];
	[request setPostValue:password.text forKey:@"password"];
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestFailed:)];
	[request startAsynchronous];
}

- (IBAction)cancel:(id)sender {

    if (delegate && [delegate respondsToSelector:@selector(cancelLogin:)]) {
        [delegate cancelLogin:self];
    }
 
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [[appDelegate window] addSubview:self.view];

    [self.view removeFromSuperview];
    
    CATransition* animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.2;
    [[[appDelegate window] layer] addAnimation:animation forKey:nil];
    
    [userName resignFirstResponder];
    [password resignFirstResponder];
    
    [contentView setContentOffset:CGPointMake(0, 0) animated:YES];
    self.contentView.frame = CGRectMake(21, 53, 278, 398);
}

- (BOOL)isAuthorized {
 
    NSUserDefaults* database = [NSUserDefaults standardUserDefaults];
    NSString* username = [database objectForKey:@"twitter_username"];
    NSString* pass = [database objectForKey:@"twitter_password"];

    if (username == nil && pass == nil) {
        return NO;
    }
    
    return YES;
}

- (void)logout {
    
    NSUserDefaults* database = [NSUserDefaults standardUserDefaults];
    [database removeObjectForKey:@"twitter_username"];
    [database removeObjectForKey:@"twitter_password"];
    [database synchronize];
    
    if (delegate && [delegate respondsToSelector:@selector(didLogOut:)]) {
        [delegate didLogOut:self];
    }
}

- (void)authorize {

    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [[appDelegate window] addSubview:self.view];
    
    self.contentView.frame = CGRectMake(21, 53, 278, 398);
    self.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
	[UIView beginAnimations:@"scale" context:NULL];
	self.view.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:0.2];
	[UIView commitAnimations];

}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	
	if ([animationID isEqualToString:@"scale"]) {
		
		[UIView beginAnimations:nil context:NULL];
		self.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:0.2];
		[UIView commitAnimations];
		
		return;
	}
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    CGRect oldFrame = contentView.frame;
    contentView.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, 210);
    
    if (textField == userName) {
        [self.contentView setContentOffset:CGPointMake(0, 150) animated:YES];
    }
    
    if (textField == password) {
        [self.contentView setContentOffset:CGPointMake(0, 180) animated:YES];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (textField == userName) {
        [password becomeFirstResponder];
    }
    
    if (textField == password) {
        [password resignFirstResponder];
        CGRect oldFrame = contentView.frame;
        contentView.frame = CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, 398);
    }
    
    return YES;
}


@end
