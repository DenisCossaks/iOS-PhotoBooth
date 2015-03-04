//
//  HomeViewController.m
//  JuicedUpPhotoBooth
//
//  Created by Administrator on 6/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "AboutViewController.h"
#import "MainViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)onJuiceUp:(id)sender
{
	MainViewController * mainView = [[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil] autorelease];
	[self.navigationController pushViewController:mainView animated:TRUE];
}

-(IBAction)onInfo:(id)sender
{
	AboutViewController * aboutView = [[[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil] autorelease];
	[self.navigationController pushViewController:aboutView animated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.navigationController.navigationBar.hidden = YES;
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
