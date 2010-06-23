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

@implementation PlayerInfo

-(id) init
{
	self = [super init];
	
	if (self)
	{
		self.scale = 0.8f;
		[self setContentSize:CGSizeMake(300, 40)];
		CCTexture2D *useImgTexture = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"tibentanmastiff_rest_01.png" ofType:nil] ] ];
		userImgSprite = [[CCSprite node] retain];
		[userImgSprite setTexture:useImgTexture];
		[userImgSprite setContentSize:CGSizeMake(40, 40)];
		userImgSprite.position = ccp(20,20);
		userNameLbl = [[CCLabel labelWithString:@"" fontName:@"Arial" fontSize:12] retain];
		userNameLbl.position = ccp(60,30);
		experienceBar = [[CCLabel labelWithString:@"" fontName:@"Arial" fontSize:12] retain];
		experienceBar.position = ccp(120,30);
		levelLbl = [[CCLabel labelWithString:@"" fontName:@"Arial" fontSize:12] retain];
		levelLbl.position = ccp(170,30);
		animalNumLbl = [[CCLabel labelWithString:@"" fontName:@"Arial" fontSize:12] retain];
		animalNumLbl.position = ccp(220,30);
		CCSprite *antIcon = [CCSprite spriteWithFile:@"蚂蚁ICO.png"];
		[antIcon setContentSize:CGSizeMake(10, 10)];
		antIcon.position = ccp(50,10);
		antIcon.scale = 0.5f;
		antsNumLbl = [[CCLabel labelWithString:@"" fontName:@"Arial" fontSize:12] retain];
		antsNumLbl.position = ccp(80,10);
		CCSprite *eggIcon = [CCSprite spriteWithFile:@"金蛋ico.png"];
		[eggIcon setContentSize:CGSizeMake(10, 10)];
		eggIcon.position = ccp(100,10);
		eggIcon.scale =0.5f;
		goldenEggNumLbl = [[CCLabel labelWithString:@"" fontName:@"Arial" fontSize:12] retain];
		goldenEggNumLbl.position = ccp(140,10);
		capacity = [[CCLabel labelWithString:@"" fontName:@"Arial" fontSize:12] retain];
		capacity.position = ccp(200,10);
		[self addChild:userImgSprite z:1];
		[self addChild:userNameLbl z:1];
		[self addChild:experienceBar z:1];
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
	}
	CCTexture2D *useImgTexture = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:userImg ofType:nil] ] ];
	[userImgSprite setTexture:useImgTexture];
	[userNameLbl setString:userName];
	[experienceBar setString:[NSString stringWithFormat:@"%@/%@",currentExperience,nextLevelExperience]];
	[levelLbl setString:[NSString stringWithFormat:@"%@ 级",level]];
	[animalNumLbl setString:[NSString stringWithFormat:@"动物数量: %@",animalNum]];
	[antsNumLbl setString:antsNum];
	[goldenEggNumLbl setString:goldenEggNum];
	[capacity setString:[NSString stringWithFormat:@"容量: %@/%@",maxNumOfBirds,topMaxNumOfBirds]];
	
}
@end
