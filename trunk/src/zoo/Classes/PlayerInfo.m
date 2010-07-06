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
		self.scale = 0.8f;
//		[self setContentSize:CGSizeMake(300, 40)];
		CCTexture2D *useImgTexture = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Icon.png" ofType:nil] ] ];
		userImgSprite = [CCSprite node];/// retain];
		[userImgSprite setTexture:useImgTexture];
		[useImgTexture release];
		
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"用户_bg.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];		
		[self setTextureRect: rect];
		[bg release];
		
		//头像
		[userImgSprite setContentSize:CGSizeMake(40, 40)];
		userImgSprite.position = ccp(60,130);
		//名字
		userNameLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:18];//retain];
		[userNameLbl setColor:ccc3(0, 0, 0)];
		userNameLbl.position = ccp(85,40);
		//金蛋、数目
		CCSprite *eggIcon = [CCSprite spriteWithFile:@"金蛋ico.png"];
		[eggIcon setContentSize:CGSizeMake(10, 10)];
		eggIcon.position = ccp(120,36);
		goldenEggNumLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:15];// retain];
		[goldenEggNumLbl setColor:ccc3(0, 0, 0)];
		goldenEggNumLbl.position = ccp(150,40);
		//蚂蚁、数目
		CCSprite *antIcon = [CCSprite spriteWithFile:@"蚂蚁ICO.png"];
		[antIcon setContentSize:CGSizeMake(10, 10)];
		antIcon.position = ccp(185,36);
		antsNumLbl = [CCLabel labelWithString:@"" fontName:@"Arial" fontSize:15];// retain];
		[antsNumLbl setColor:ccc3(0, 0, 0)];
		antsNumLbl.position = ccp(210,40);
		
		CCSprite *animalIcon = [CCSprite spriteWithFile:@"信息背景.png"];
		animalIcon.position = ccp(274,29);
//		animalIcon.scaleX = 1.1;
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
		
		
		
		[self addChild:userImgSprite z:1];
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

-(void) updateUserInfo
{
	DataModelFarmerInfo *farmerInfo = (DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo;
	DataModelFarmerInfo *friendInfo = (DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].friendFarmerInfo;
	DataModelFarmInfo *farmInfo = (DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo;
	DataModelFarmInfo *friendFarmInfo = (DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].friendFarmInfo;
	animalNum = [NSString stringWithFormat:@"%d",[[DataEnvironment sharedDataEnvironment].animalIDs count]];
	if ([[ModelLocator sharedModelLocator] getIsSelfZoo]) {
		userName = farmerInfo.userName;
		userImg = farmerInfo.userImg;
		currentExperience = [NSString stringWithFormat:@"%d",farmInfo.farm_currentExp];
		nextLevelExperience = [NSString stringWithFormat:@"%d", farmInfo.farm_nextLevelExp];
		level = [NSString stringWithFormat:@"%d", farmInfo.farm_level];
		maxNumOfBirds = [NSString stringWithFormat:@"%d", farmInfo.farm_maxNumOfBirds];
		topMaxNumOfBirds = [NSString stringWithFormat:@"%d", farmInfo.farm_topMaxNumOfBirds];
		antsNum = [NSString stringWithFormat:@"%d", farmerInfo.antsCurrency];
		goldenEggNum = [NSString stringWithFormat:@"%d", farmerInfo.goldenEgg];
		
		float nNowExperience = currentExperience.floatValue;
		float nAllExperience = nextLevelExperience.floatValue;
		nColorBar = nNowExperience/nAllExperience*120.0;
	}else {
		userName = friendInfo.userName;
		userImg = friendInfo.userImg;
		currentExperience = [NSString stringWithFormat:@"%d", friendFarmInfo.farm_currentExp];
		nextLevelExperience = [NSString stringWithFormat:@"%d", friendFarmInfo.farm_nextLevelExp];
		level = [NSString stringWithFormat:@"%d", friendFarmInfo.farm_level];
		maxNumOfBirds = [NSString stringWithFormat:@"%d", friendFarmInfo.farm_maxNumOfBirds];
		topMaxNumOfBirds =[NSString stringWithFormat:@"%d", friendFarmInfo.farm_topMaxNumOfBirds];
		antsNum = [NSString stringWithFormat:@"%d", friendInfo.antsCurrency];
		goldenEggNum = [NSString stringWithFormat:@"%d", friendInfo.goldenEgg];
		
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
	
	
	CCTexture2D *useImgTexture = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:userImg ofType:nil] ] ];
	[userImgSprite setTexture:useImgTexture];
	
	//
	[useImgTexture release];
	
	[userNameLbl setString:userName];
	[experienceBar setString:[NSString stringWithFormat:@"%@/%@",currentExperience,nextLevelExperience]];
	[levelLbl setString:[NSString stringWithFormat:@"%@级",level]];
	[animalNumLbl setString:[NSString stringWithFormat:@"动物:%@",animalNum]];
	[antsNumLbl setString:antsNum];
	[goldenEggNumLbl setString:goldenEggNum];
	[capacity setString:[NSString stringWithFormat:@"容量:%@/%@",maxNumOfBirds,topMaxNumOfBirds]];
	
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[userName release];
	[userImg release];
	[currentExperience release];
	[nextLevelExperience release];
	[level release];
	[maxNumOfBirds release];
	[topMaxNumOfBirds release];
	[animalNum release];
	[antsNum release];
	[goldenEggNum release];
	[userNameLbl release];
	[experienceLbl release];
	[experienceBar release];
	[levelLbl release];
	[capacity release];
	[antsNumLbl release];
	[goldenEggNumLbl release];
	[animalNumLbl release];
	[userImgSprite release];
	
	// For retain
	[userImgSprite release];
	[userNameLbl release];
	[experienceBar release];
	[levelLbl release];
	[animalNumLbl release];
	[antsNumLbl release];
	[goldenEggNumLbl release];
	[capacity release];


	[super dealloc];
}


@end
