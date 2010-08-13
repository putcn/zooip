    //
//  Hybridization.m
//  zoo
//
//  Created by Hunk on 10-8-13.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import "Hybridization.h"

#define SAFE_RELEASE(p) {if(p != nil) [p release]; p = nil;}

@implementation Hybridization


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	[self.view setFrame:CGRectMake(0.f, 0.f, 480.f, 320.f)];
	[self.view setBackgroundColor:[UIColor clearColor]];
	
	// Bg
	UIImageView* bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(80, 100, 320, 200)];
	[bgImage setImage:[UIImage imageNamed:@"BG_buy.png"]];
	[self.view addSubview:bgImage];
	SAFE_RELEASE(bgImage)
	
	// Title
	UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 100, 80, 40)];
	[titleLabel setBackgroundColor:[UIColor clearColor]];
	titleLabel.text = @"交配";
	[self.view addSubview:titleLabel];
	SAFE_RELEASE(titleLabel)
	
	// Exit button
	UIButton* exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[exitBtn setImage:[UIImage imageNamed: @"exitButton.png"] forState:UIControlStateNormal];
	exitBtn.frame = CGRectMake(376, 276, 30, 30);
	[exitBtn addTarget:self action:@selector(exitBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:exitBtn];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(void)exitBtnSelected:(id)sender
{
	[self.view removeFromSuperview];
}

- (void)dealloc 
{
    [super dealloc];
}


@end
