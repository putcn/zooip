    //
//  MarryView.m
//  zoo
//
//  Created by Hunk on 10-8-12.
//  Copyright 2010 Vanceinfo. All rights reserved.
//

#import "MarryView.h"
#import "ServiceHelper.h"
#import "StorageManageToolbar.h"
#import "GameMainScene.h"
#import "AnimalController.h"
#import "GetAllBirdFarmAnimalInfoController.h"
#import "DataEnvironment.h"
#import "DataModelStorageAnimal.h"
#import "DataModelStorageAuctionAnimal.h"

#define SAFE_RELEASE(p) {if(p != nil) [p release]; p = nil;}


@implementation MarryView
@synthesize leftAnimalID, rightAnimalID, m_arrANIMALID;


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
	titleLabel.text = @"动物结婚";
	[self.view addSubview:titleLabel];
	SAFE_RELEASE(titleLabel)
	
	// Left animal frame
	UIButton* leftAnimalBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 130, 80, 80)];
	[leftAnimalBtn setImage:[UIImage imageNamed:@"边框.png"] forState:UIControlStateNormal];
	[leftAnimalBtn setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:leftAnimalBtn];
	SAFE_RELEASE(leftAnimalBtn)
	
	// Right animal frame
	UIButton* rightAnimalBtn = [[UIButton alloc]initWithFrame:CGRectMake(290, 130, 80, 80)];
	[rightAnimalBtn setImage:[UIImage imageNamed:@"边框.png"] forState:UIControlStateNormal];
	[rightAnimalBtn setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:rightAnimalBtn];
	SAFE_RELEASE(rightAnimalBtn)
	
	
	// Marry button
	UIButton* marryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	marryBtn.frame = CGRectMake(210, 135, 60, 30);
	[marryBtn setBackgroundImage:[UIImage imageNamed: @"确定.png"] forState:UIControlStateNormal];
	marryBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
	[marryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[marryBtn setTitle:@"结婚" forState:UIControlStateNormal];
	[marryBtn addTarget:self action:@selector(marryBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:marryBtn];
	
	// hybridization button
	UIButton* hybridizationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	hybridizationBtn.frame = CGRectMake(210, 175, 60, 30);
	[hybridizationBtn setBackgroundImage:[UIImage imageNamed: @"确定.png"] forState:UIControlStateNormal];
	hybridizationBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
	[hybridizationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[hybridizationBtn setTitle:@"配种" forState:UIControlStateNormal];
	[hybridizationBtn addTarget:self action:@selector(hybridizationBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:hybridizationBtn];
	
	// Hint
	UILabel* hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 200, 160, 30)];
	[hintLabel setBackgroundColor:[UIColor clearColor]];
	hintLabel.text = @"请选择异性动物:";
	[self.view addSubview:hintLabel];
	SAFE_RELEASE(hintLabel)
	
	// Scroll view
	animalScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(90, 220, 300, 75)];
	
	// Exit button
	UIButton* exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[exitBtn setImage:[UIImage imageNamed: @"exitButton.png"] forState:UIControlStateNormal];
	exitBtn.frame = CGRectMake(376, 276, 30, 30);
	[exitBtn addTarget:self action:@selector(exitBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:exitBtn];
	
	m_nSelectedAniIndex = -1;
	m_nSexIndex = -1;
	

}

-(void)marryBtnSelected:(id)sender
{
	NSString *action = @"marry";
	NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
	
	DataModelAnimal *serverAnimalDataOne = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:leftAnimalID];
	
	if(leftAnimalID == nil || rightAnimalID == nil)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"选择异性"];
	}
	else
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",leftAnimalID,@"maleId",rightAnimalID,@"femaleId",action,@"action",nil];
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoMateAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackMarry:" AndFailedSel:@"faultCallback:"];

		serverAnimalDataOne.coupleAnimalId = rightAnimalID;
		DataModelAnimal *serverAnimalDataRight = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:rightAnimalID];
		serverAnimalDataRight.coupleAnimalId = leftAnimalID;
	}
}

-(void)hybridizationBtnSelected:(id)sender
{}

-(void)exitBtnSelected:(id)sender
{
	m_nSelectedAniIndex = -1;
	m_nSexIndex = -1;
	
	for (UIView *subview in animalScrollView.subviews) 
	{
		[subview removeFromSuperview];
	}
	[rightUpImageView removeFromSuperview];
	[leftUpImageView removeFromSuperview];
	
	[self.view removeFromSuperview];
}

- (void)selectButtonAtIndex:(NSUInteger)index
{
	
	prevButtonIndex = index;
}

- (void)deselectButtonAtIndex:(NSUInteger)prevIndex
{
	
	m_nprevButtonIndex = -1;
}

- (void)buttonSelected:(id)sender
{
	UIButton *selectedBtn = (UIButton *)sender;
	NSUInteger index = selectedBtn.tag;
	
//	if (index != prevButtonIndex) 
//	{
//		[self deselectButtonAtIndex:prevButtonIndex];
//		[self selectButtonAtIndex:index];
//	}
	
	rightAnimalID = [m_arrANIMALID objectAtIndex:index];
	
	
	
	if(index != m_nSelectedAniIndex)
	{
		[leftUpImageView removeFromSuperview];
		// left up animal
		leftUpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[m_arrPic objectAtIndex:index]]];
		
		if(m_nSexIndex == 0)
		{
			leftUpImageView.frame = CGRectMake(110, 140, 60, 60);
		}
		else
		{
			leftUpImageView.frame = CGRectMake(300, 140, 60, 60);
		}

		m_nSelectedAniIndex = index;
		[self.view addSubview:leftUpImageView];
	}
}

-(void)addUpAnimal:(NSString*)upAnimalName sex:(int)sexIndex
{
	m_nSexIndex = sexIndex;
	
	// Right up animal
	rightUpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:upAnimalName]];
	
	if(sexIndex == 0)
	{
		rightUpImageView.frame = CGRectMake(300, 140, 60, 60);
	}
	else
	{
		rightUpImageView.frame = CGRectMake(110, 140, 60, 60);
	}
	
	[self.view addSubview:rightUpImageView];
}

-(void)initScrollViewItems:(NSMutableArray*)picArray aniID:(NSMutableArray*)idArray
{
	m_arrANIMALID = [[NSMutableArray alloc]init];
	[m_arrANIMALID removeAllObjects];
	[m_arrANIMALID addObjectsFromArray:idArray];
	
	m_arrPic = [[NSMutableArray alloc]init];
	[m_arrPic removeAllObjects];
	[m_arrPic addObjectsFromArray:picArray];
	
	animalScrollView.userInteractionEnabled = YES;
	animalScrollView.scrollEnabled = YES;
	[animalScrollView setContentSize:CGSizeMake(60, animalScrollView.frame.size.height)];
	[animalScrollView setBackgroundColor:[UIColor clearColor]];
	animalScrollView.alpha = 1;
	[animalScrollView setShowsHorizontalScrollIndicator:NO];
	[animalScrollView setShowsVerticalScrollIndicator:NO];
	[self.view addSubview:animalScrollView];
	
	
	for(int i = 0; i < [picArray count]; i++) 
	{
		UIButton* showAniBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[showAniBtn setImage:[UIImage imageNamed: @"边框.png"] forState:UIControlStateNormal];
		showAniBtn.frame = CGRectMake(5 + 60*(i), 0, 60, 60);
		[showAniBtn addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
		[animalScrollView addSubview:showAniBtn];
		showAniBtn.tag = i;
		
		
		 // Animal
		 UIImageView* imageAni = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[picArray objectAtIndex:i]]];
		 imageAni.frame = CGRectMake(5 + 60*(i), 0, 60, 60);
		 [animalScrollView addSubview:imageAni];
		 [imageAni release];
		 imageAni = nil;
		 
	}
	//[self selectButtonAtIndex:0];
}

-(void) resultCallbackMarry:(NSObject *)value
{
	NSDictionary* dic = (NSDictionary*)value;
 	NSInteger code = [[dic objectForKey:@"code"] intValue];
	
	switch (code) {
		case 1:
		{
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"结婚成功"];
			((DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:leftAnimalID]).coupleAnimalId = rightAnimalID;
			((DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:rightAnimalID]).coupleAnimalId = leftAnimalID;
		}
			break;
		case 2:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"结婚成功"];
			break;
		case 4:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不是自己的公动物，不能配对"];
			break;
		case 5:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不是自己的母动物，不能配对"];
			break;
		case 8:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"近亲不能结婚"];
			break;
		default:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"结婚失败"];
			break;
	}
	NSLog(@"操作已成功!");
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc 
{
	SAFE_RELEASE(animalScrollView)
	SAFE_RELEASE(rightUpImageView)
	SAFE_RELEASE(leftUpImageView)
	
	SAFE_RELEASE(m_arrPic)
	
    [super dealloc];
}


@end
