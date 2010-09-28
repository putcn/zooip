//
//  PlayerInfo.m
//  Zoo
//
//  Created by Gu Lei on 10-4-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayerInfo.h"
#import "GameMainScene.h"
#import "DataEnvironment.h"
#import "DataModelFarmerInfo.h"
#import "DataModelFarmInfo.h"
#import "DataModelFriendInfo.h"
#import "ModelLocator.h"
#import "LoadingBar.h"

@implementation PlayerInfo

-(id) init
{
	self = [super init];
	
	if (self)
	{
		nColorBar = 0;
		
		self.scale = 0.8f;
//		DataModelFarmerInfo *farmerInfo = (DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo;
//		DataModelFarmerInfo *friendInfo = (DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].friendFarmerInfo;
//		if ([[ModelLocator sharedModelLocator] getIsSelfZoo]) {
//			userName = [farmerInfo.userName retain];
//			userImgNow = [farmerInfo.userImg retain];
//		}
//		else {
//			userName = [friendInfo.userName retain];
//			userImgNow = [friendInfo.userImg retain];
//		}
		
		
//		[self setContentSize:CGSizeMake(300, 40)];
//		CCTexture2D *useImgTexture = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"http://www.cocoqq.com/upimg/090128/12331420cO3Z555Z1.gif" ofType:nil] ] ];
//		CGRect rect_1 = CGRectZero;
//		rect_1.size = useImgTexture.contentSize;
//		userImgSprite = [CCSprite node];/// retain];
//		[userImgSprite setTexture:useImgTexture];
//		[userImgSprite setTextureRect: rect_1];
//		[useImgTexture release];
		
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"用户_bg.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];		
		[self setTextureRect: rect];
		[bg release];
		
//		imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,100,100)];
//		imgView.backgroundColor = [UIColor blackColor];
//		[[[CCDirector sharedDirector] openGLView] addSubview:imgView];
////		[self addSubview:imgView];
//		[imgView release];
//		
		
		//头像
//		[userImgSprite setContentSize:CGSizeMake(40, 40)];
//		userImgSprite.position = ccp(30,30);
		//名字
		userNameLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:18];//retain];
		[userNameLbl setColor:ccc3(0, 0, 0)];
		userNameLbl.position = ccp(80,40); // 85
		//金蛋、数目
		CCSprite *eggIcon = [CCSprite spriteWithFile:@"金蛋ico.png"];
		[eggIcon setContentSize:CGSizeMake(10, 10)];
		eggIcon.position = ccp(110,36); // 120
		goldenEggNumLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:15];// retain];
		[goldenEggNumLbl setColor:ccc3(0, 0, 0)];
		goldenEggNumLbl.position = ccp(145,40);
		//蚂蚁、数目
		CCSprite *antIcon = [CCSprite spriteWithFile:@"蚂蚁ICO.png"];
		[antIcon setContentSize:CGSizeMake(10, 10)];
		antIcon.position = ccp(180,36);
		antsNumLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:15];// retain];
		[antsNumLbl setColor:ccc3(0, 0, 0)];
		antsNumLbl.position = ccp(210,40);
		
		CCSprite *animalIcon = [CCSprite spriteWithFile:@"信息背景.png"];
		animalIcon.position = ccp(274,29);
		[self addChild:animalIcon z:0];
		//动物数量
		animalNumLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:15];// retain];
		[animalNumLbl setColor:ccc3(0, 0, 0)];
		animalNumLbl.position = ccp(270,40);
		//动物容量
		capacity = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:15];// retain];
		[capacity setColor:ccc3(0, 0, 0)];
		capacity.position = ccp(275,16);
		
		experienceBar = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:14];// retain];
		[experienceBar setColor:ccc3(0, 0, 0)];
		experienceBar.position = ccp(125,15);
		//等级
		levelLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:18];// retain];
		[levelLbl setColor:ccc3(0, 0, 0)];
		levelLbl.position = ccp(210,16);
		
//		[self addChild:userImgSprite z:4];
		[self addChild:userNameLbl z:1];
		[self addChild:experienceBar z:2];
		[self addChild:levelLbl z:1];
		[self addChild:animalNumLbl z:1];
		[self addChild:antIcon z:1];
		[self addChild:antsNumLbl z:1];
		[self addChild:eggIcon z:1];
		[self addChild:goldenEggNumLbl z:1];
		[self addChild:capacity z:1];
	}
	
	return self;
}

-(void)updateUserInfo
{
	DataModelFarmerInfo *farmerInfo = (DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo;
	DataModelFarmerInfo *friendInfo = (DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].friendFarmerInfo;
	DataModelFarmInfo *farmInfo = (DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo;
	DataModelFarmInfo *friendFarmInfo = (DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].friendFarmInfo;
	animalNum = [NSString stringWithFormat:@"%d",[[DataEnvironment sharedDataEnvironment].animalIDs count]];
	if ([[ModelLocator sharedModelLocator] getIsSelfZoo]) {
		userName = [farmerInfo.userName retain];
		userImgNow = [farmerInfo.userImg retain];
		currentExperience = [[NSString stringWithFormat:@"%d",farmInfo.farm_currentExp] retain];
		nextLevelExperience = [[NSString stringWithFormat:@"%d", farmInfo.farm_nextLevelExp] retain];
		level = [[NSString stringWithFormat:@"%d", farmInfo.farm_level] retain];
		maxNumOfBirds = [[NSString stringWithFormat:@"%d", farmInfo.farm_maxNumOfBirds] retain];
		topMaxNumOfBirds = [[NSString stringWithFormat:@"%d", farmInfo.farm_topMaxNumOfBirds] retain];
		
		//NSLog(@"%d\n", farmerInfo.antsCurrency);
		
		//antsNumLbl
		antsNum = [[NSString stringWithFormat:@"%d", farmerInfo.antsCurrency] retain];
		// Add by Hunk on 2010-07-28
		int nAntsNumLength = [antsNum length];
		switch (nAntsNumLength)
		{
			case 1:
			case 2:
			{
				antsNumLbl.position = ccp(215, 40);
			}
				break;
			case 3:
			case 4:
			{
				antsNumLbl.position = ccp(215, 40);
			}
				break;
			case 5:
			case 6:
			{
				antsNumLbl.position = ccp(212,40);
			}
				break;
			default:
			{
				antsNumLbl.position = ccp(212,40);
			}
				break;
		}
		
		goldenEggNum = [[NSString stringWithFormat:@"%d", farmerInfo.goldenEgg] retain];
		// Add by Hunk on 2010-07-28
		int nGoldenEggNumLength = [goldenEggNum length];
		switch (nGoldenEggNumLength)
		{
			case 1:
			case 2:
			{
				goldenEggNumLbl.position = ccp(155, 40);
			}
				break;
			case 3:
			case 4:
			{
				goldenEggNumLbl.position = ccp(150, 40);
			}
				break;
			case 5:
			case 6:
			{
				goldenEggNumLbl.position = ccp(145,40);
			}
				break;
			default:
			{
				goldenEggNumLbl.position = ccp(145,40);
			}
				break;
		}
		
		
		float nNowExperience = currentExperience.floatValue;
		float nAllExperience = nextLevelExperience.floatValue;
		nColorBar = nNowExperience/nAllExperience*120.0;
	}else {
		userName = [friendInfo.userName retain];
		userImgNow = [friendInfo.userImg retain];
		
		NSLog(@"%@\n", userImgNow);
		
		currentExperience = [[NSString stringWithFormat:@"%d", friendFarmInfo.farm_currentExp] retain];
		nextLevelExperience = [[NSString stringWithFormat:@"%d", friendFarmInfo.farm_nextLevelExp] retain];
		level = [[NSString stringWithFormat:@"%d", friendFarmInfo.farm_level] retain];
		maxNumOfBirds = [[NSString stringWithFormat:@"%d", friendFarmInfo.farm_maxNumOfBirds] retain];
		topMaxNumOfBirds = [[NSString stringWithFormat:@"%d", friendFarmInfo.farm_topMaxNumOfBirds] retain];
		antsNum = [[NSString stringWithFormat:@"%d", friendInfo.antsCurrency] retain];
		goldenEggNum = [[NSString stringWithFormat:@"%d", friendInfo.goldenEgg] retain];
		
		float nNowExperience = currentExperience.floatValue;
		float nAllExperience = nextLevelExperience.floatValue;
		nColorBar = nNowExperience/nAllExperience*120.0;
	}
	int nPercent = 0;
	if(nColorBar != 0)
	{
		nPercent = 1;
	}
	if(120 - nColorBar < 1 )
	{
		nPercent = 2;
	}
	//经验
	CCSprite *load_yellow_left = [CCSprite spriteWithFile:@"BG左圆角.png"];
	CCSprite *load_yellow_middle = [CCSprite spriteWithFile:@"BG中间.png"];
	CCSprite *load_yellow_right = [CCSprite spriteWithFile:@"BG右圆角.png"];
	CCSprite *load_yellow_Cololeft = [CCSprite spriteWithFile:@"进度_左圆角.png"];
	CCSprite *load_yellow_Colomiddle = [CCSprite spriteWithFile:@"进度_中间.png"];
	CCSprite *load_yellow_Coloright = [CCSprite spriteWithFile:@"进度_右圆角.png"];
	
	LoadingBar *load_yellow = [[LoadingBar alloc] initWithCCSprite:@"" setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:15 setTarget:self 
													 setSpriteLeft:load_yellow_left setSpriteMidele: load_yellow_middle setSpriteRight: load_yellow_right
												 setSpriteColoLeft: load_yellow_Cololeft setSpriteColoMidele: load_yellow_Colomiddle setSpriteColoRight: load_yellow_Coloright
														   offsetX:120 offsetY:(int)nColorBar setpercent:nPercent setLength:1 setTextLegth:-5 - 80*2 setTextHight:14];
	load_yellow.position = ccp(62 , 9);
	[self addChild:load_yellow z:1];
	
	
	nextPageBtn = [[Button alloc] initWithLabel:@"" 
									   setColor:ccc3(255, 255, 255) 
										setFont:@"Arial" setSize:12 
								  setBackground:@"返回.png" 
									  setTarget:self 
									setSelector:@selector(btnPlayerOperationButtonHandler:) 
									setPriority:50 offsetX:0 offsetY:0 scale:1.0f];
	nextPageBtn.position = ccp(332,30);
	[self addChild:nextPageBtn z:3];
	
	
	if (userImgNow == nil)
	{
		userImgNow = @"http://www.cocoqq.com/upimg/090128/12331420cO3Z555Z1.gif";
	}

	// add by ziwei 
//	if(pic == nil)
	// Modified by Hunk on 2010-09-28
	pic = [[PictureAdd alloc] initWithPicUrl:userImgNow setPointX:275 setPointY:5];
	
//  兰溪版本
//	[pic setImagePoint:280 setPointY:70];
//	UIImageView *_xxxView = [[[CCDirector sharedDirector] openGLView] viewWithTag:999];
//	_xxxView.hidden = YES;
//	imgView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,50,50)];
////	[imgView setScalesPageToFit:YES];    
//	[imgView setBackgroundColor:[UIColor yellowColor]];
//	[imgView setOpaque:NO];
//	
//	
//	NSURL* url = [NSURL URLWithString:userImgNow];
//	NSURLRequest* req = [NSURLRequest requestWithURL:url];
//	[imgView loadRequest:req];
//	imgView.transform = CGAffineTransformMakeRotation(M_PI * (90.0 / 180.0));
//	//[self addChild:imgView];
//	[[[UIApplication sharedApplication]keyWindow]addSubview:imgView];
	
	
//天虹版本
//	NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: userImgNow]];
//	
//	if (imageData == nil)
//	{
//		imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: @"http://www.cocoqq.com/upimg/090128/12331420cO3Z555Z1.gif"]];
//	}	
//	CCTexture2D *useImgTexture = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithData:imageData] ];
//	CGRect rect = CGRectZero;
//	rect.size = useImgTexture.contentSize;
//	[userImgSprite setTexture: useImgTexture];
//	[userImgSprite setTextureRect: rect];
//	userImgSprite.scale = 40.0f/useImgTexture.contentSize.height;
//	[useImgTexture release];
//	[imageData release];
	
	
	[userNameLbl setString:userName];
	[experienceBar setString:[NSString stringWithFormat:@"%@/%@",currentExperience,nextLevelExperience]];
	[levelLbl setString:[NSString stringWithFormat:@"%@级",level]];
	[animalNumLbl setString:[NSString stringWithFormat:@"动物:%@",animalNum]];
	[antsNumLbl setString:antsNum];
	[goldenEggNumLbl setString:goldenEggNum];
	[capacity setString:[NSString stringWithFormat:@"容量:%@/%@",maxNumOfBirds,topMaxNumOfBirds]];
}


-(void) btnPlayerOperationButtonHandler:(Button *)button
{	
	if(self.position.x > 0)
	{
		id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(-120, self.position.y)];
		id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveOutFinished)];
		
		id ease = [CCEaseBackIn actionWithAction: actionMove];
		[ease setDuration:0.3];
		
		[self runAction:[CCSequence actions:ease, actionMoveDone, nil]];
		
	}
	else 
	{
		id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(130, self.position.y)];
		id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveInFinished)];
		
		id ease = [CCEaseBackOut actionWithAction: actionMove];
		[ease setDuration:0.3];
		
		[self runAction:[CCSequence actions:ease, actionMoveDone, nil]];
		
		
	}
}
-(void)spriteMoveOutFinished
{
	nextPageBtn = [[Button alloc] initWithLabel:@"" 
									   setColor:ccc3(255, 255, 255) 
										setFont:@"Arial" setSize:12 
								  setBackground:@"返回1.png" 
									  setTarget:self 
									setSelector:@selector(btnPlayerOperationButtonHandler:) 
									setPriority:50 offsetX:0 offsetY:0 scale:1.0f];
	nextPageBtn.position = ccp(332,30);
	[self addChild:nextPageBtn z:3];
	[pic setImagePoint:-275 setPointY:5];
}

-(void)spriteMoveInFinished
{
	nextPageBtn = [[Button alloc] initWithLabel:@"" 
									   setColor:ccc3(255, 255, 255) 
										setFont:@"Arial" setSize:12 
								  setBackground:@"返回.png" 
									  setTarget:self 
									setSelector:@selector(btnPlayerOperationButtonHandler:) 
									setPriority:50 offsetX:0 offsetY:0 scale:1.0f];
	nextPageBtn.position = ccp(332,30);
	[self addChild:nextPageBtn z:3];
	[pic setImagePoint:275 setPointY:5];
}



// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[pic release];
	
	[userName release];
	[userImgNow release];
	[currentExperience release];
	[nextLevelExperience release];
	[level release];
	[maxNumOfBirds release];
	[topMaxNumOfBirds release];
	[animalNum release];
	[antsNum release];
	[goldenEggNum release];
	[experienceBar release];
	[capacity release];
//	[userImgSprite release];
	
	// For retain
	[experienceBar release];
	[capacity release];


	[super dealloc];
}


@end
