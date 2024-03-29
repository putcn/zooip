//
//  DisapartView.m
//  zoo
//
//  Created by AlexLiu on 8/16/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import "ServiceHelper.h"
#import "StorageManageToolbar.h"
#import "GameMainScene.h"
#import "AnimalController.h"
#import "GetAllBirdFarmAnimalInfoController.h"
#import "DataEnvironment.h"
#import "DataModelStorageAnimal.h"
#import "DataModelStorageAuctionAnimal.h"
#import "popViewManager.h"

#define SAFE_RELEASE(p) {if(p != nil) [p release]; p = nil;}


@implementation DisapartView
@synthesize leftAnimalID, rightAnimalID, m_arrANIMALID, m_arrayDiapartAnimalID;

@synthesize rightUpImageView, leftUpImageView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	tempLeft = leftAnimalID;
	tempRight = rightAnimalID;
	//ants choose init.
	secPopView = [[SecPopViewController alloc] initWithNibName:@"SecPopViewController" bundle:nil];
	
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
	titleLabel.text = @"动物离婚";
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
	[marryBtn setTitle:@"离婚" forState:UIControlStateNormal];
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

	m_arrANIMALID = [[NSMutableArray alloc]init];
}

//动物离婚
-(void)marryBtnSelected:(id)sender
{
	NSString *action = @"marry";
	NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
	
	DataModelAnimal *serverAnimalDataOne = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:leftAnimalID];


	NSLog(@"%@\n",leftAnimalID);
	NSLog(@"%@\n",rightAnimalID);
	
	if(leftAnimalID == nil || rightAnimalID == nil)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"选择异性"];
	}
	else
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
								farmId,@"farmId",
								leftAnimalID,@"maleId",
								rightAnimalID,@"femaleId",nil];
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoDisbandMateAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackMarry:" AndFailedSel:@"faultCallback:"];
		
		serverAnimalDataOne.coupleAnimalId = rightAnimalID;
		DataModelAnimal *serverAnimalDataRight = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:rightAnimalID];
		serverAnimalDataRight.coupleAnimalId = leftAnimalID;
	}
}

//动物婚后交配按钮选择
-(void)hybridizationBtnSelected:(id)sender
{
	[secPopView.animalIDArray removeAllObjects];
	[secPopView setM_npopViewType:ANIMAL_ANTSCHOOSE_POPVIEW];
	[secPopView setM_ntabFlag:Mate_After_Marry];
	[secPopView.animalIDArray addObject:leftAnimalID];
	[secPopView.animalIDArray addObject:rightAnimalID];
	//[secPopView.animalIDArray addObject:tempLeft];
//	
//	NSString* fileName = [picFileNameArray objectAtIndex:index];
	[secPopView setItemId:index];
	[self.view addSubview:secPopView.view];
	[secPopView setShowImageName:@""];
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

//离婚界面退出
-(void)exitBtnSelected:(id)sender
{
	m_nSelectedAniIndex = -1;
	m_nSexIndex = -1;
	
	[rightUpImageView removeFromSuperview];
	[leftUpImageView removeFromSuperview];
	
	for (UIView *subview in animalScrollView.subviews) 
	{
		[subview removeFromSuperview];
	}
	
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


//动物离婚的CallBack
-(void) resultCallbackMarry:(NSObject *)value
{
	NSDictionary* dic = (NSDictionary*)value;
 	NSInteger code = [[dic objectForKey:@"code"] intValue];
	
	switch (code) {
		case 1:
		{
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"离婚成功"];
			((DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:leftAnimalID]).coupleAnimalId = nil;
			((DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:rightAnimalID]).coupleAnimalId = nil;
		}
			break;
		case 0:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不是自己的公动物，不能离婚"];
			break;
		case 2:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不是自己的母动物，不能离婚"];
			break;
		default:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"离婚失败"];
			break;
	}	
	
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
	SAFE_RELEASE(leftAnimalID)
	SAFE_RELEASE(rightAnimalID)
	SAFE_RELEASE(m_arrPic)
	
    [super dealloc];
}


@end
