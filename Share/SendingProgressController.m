//
//  SendingProgressController.m
//  ChrismasBubble
//
//  Created by Kim SongIl on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SendingProgressController.h"
#import "ASIFormDataRequest.h"
#import <QuartzCore/QuartzCore.h>

@implementation SendingProgressController

@synthesize background;

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

- (void) dealloc {
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    progressView = [[ProgressView alloc] initWithFrame:CGRectMake(39, 370, 243, 35)];
    progressView.progress = 0.0;
    [self.view addSubview:progressView];
    [progressView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {

    [self.navigationController setToolbarHidden:YES animated:NO];
//    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
//    [delegate setHiddenSnowSnowBar:YES animated:NO];

    maxValue = (((float)rand()) / RAND_MAX) / 3.0f + 0.5f;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerCallback:) userInfo:nil repeats:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)timerCallback:(id)sender {
 
    float value = progressView.progress;
    if (value >= maxValue) {
        
        [timer invalidate];
        timer = nil;
        return;
    }

    value += 0.03;
    progressView.progress = value;
}

- (void)transitionAnimation {

    CATransition* animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.1;
    [self.view.layer addAnimation:animation forKey:nil];
}

//facebook
////////////////////////////////////////////////////////////////////////////////
// FBRequestDelegate

/**
 * Called when the Facebook API request has returned a response. This callback
 * gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"received response");
}

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
	
    progressView.progress = 1.0;
	background.image = [UIImage imageNamed:@"bgSent"];
    [self performSelector:@selector(popup) withObject:nil afterDelay:3.0];
    [self transitionAnimation];
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
    
    background.image = [UIImage imageNamed:@"bgSentFailed"];
    [self performSelector:@selector(popup) withObject:nil afterDelay:3.0];
    [self transitionAnimation];
};


///twitter
- (void)requestDone:(ASIFormDataRequest*)request {
	
	NSString *response = [request responseString];
    //	[messageView close];
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    NSLog(@"staus = %@",  response);
	if ([response rangeOfString:@"Invalid twitter username or password"].location != NSNotFound) {
		UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
													 message:NSLocalizedString(@"Invalid twitter username or password." ,@"")
													delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
		[msg show];
		[msg release];
        
        NSLog(@"username = %@  password = %@", [request username], [request password]);
        background.image = [UIImage imageNamed:@"bgSentFailed"];
        [self performSelector:@selector(popup) withObject:nil afterDelay:3.0];
        [self transitionAnimation];
		return;
	}
	
	int statuscode = [request responseStatusCode];
	NSLog(@"staus = %d \n%@", statuscode, response);
	UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
												 message:NSLocalizedString(@"Successfully sent to Twitter." ,@"")
												delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
	msg.tag = 2000;
	[msg show];
	[msg release];
    progressView.progress = 1.0;
	background.image = [UIImage imageNamed:@"bgSent"];
    [self performSelector:@selector(popup) withObject:nil afterDelay:3.0];
    [self transitionAnimation];
}

- (void)requestFailed:(ASIFormDataRequest*)request {
	
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
//	UIAlertView *msg = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Information" ,@"")
//												 message:NSLocalizedString(@"Failed to send to Twitter.\nPlease check internet connection." ,@"")
//												delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",@"") otherButtonTitles:nil];
//	[msg show];
//	[msg release];
    background.image = [UIImage imageNamed:@"bgSentFailed"];
    [self performSelector:@selector(popup) withObject:nil afterDelay:3.0];
    [self transitionAnimation];
}


- (void)popup {

    [self.navigationController popViewControllerAnimated:YES];
}

@end
