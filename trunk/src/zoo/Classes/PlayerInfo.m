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
		DataModelFarmerInfo *farmerInfo = (DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo;
		DataModelFriendInfo *friendInfo = (DataModelFriendInfo *)[DataEnvironment sharedDataEnvironment].friendFarmerInfo;
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
			userImg = friendInfo.tinyurl;
			currentExperience = [NSString stringWithFormat:@"%d", friendFarmInfo.farm_currentExp];
			nextLevelExperience = [NSString stringWithFormat:@"%d", friendFarmInfo.farm_nextLevelExp];
			level = [NSString stringWithFormat:@"%d", farmInfo.farm_level];
			maxNumOfBirds = @"unknown";
			topMaxNumOfBirds = @"unknown";
			antsNum = @"unknown";
			goldenEggNum = @"unknown";
		}
		CCTexture2D *useImgTexture = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:userImg ofType:nil] ] ];
		userImgSprite = [CCSprite node];
		[userImgSprite setTexture:useImgTexture];
		[userImgSprite setContentSize:CGSizeMake(40, 40)];
		userImgSprite.position = ccp(20,20);
		userNameLbl = [CCLabel labelWithString:userName fontName:@"Arial" fontSize:12];
		userNameLbl.position = ccp(60,30);
		experienceBar = [CCLabel labelWithString:[NSString stringWithFormat:@"%@/%@",currentExperience,nextLevelExperience] fontName:@"Arial" fontSize:12];
		experienceBar.position = ccp(120,30);
		levelLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"%@ 级",level] fontName:@"Arial" fontSize:12];
		levelLbl.position = ccp(170,30);
		animalNumLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"动物数量: %@",animalNum] fontName:@"Arial" fontSize:12];
		animalNumLbl.position = ccp(220,30);
		CCSprite *antIcon = [CCSprite spriteWithFile:@"goldant.png"];
		[antIcon setContentSize:CGSizeMake(10, 10)];
		antIcon.position = ccp(50,10);
		antIcon.scale = 0.5f;
		antsNumLbl = [CCLabel labelWithString:antsNum fontName:@"Arial" fontSize:12];
		antsNumLbl.position = ccp(80,10);
		CCSprite *eggIcon = [CCSprite spriteWithFile:@"goldegg.png"];
		[eggIcon setContentSize:CGSizeMake(10, 10)];
		eggIcon.position = ccp(100,10);
		eggIcon.scale =0.5f;
		goldenEggNumLbl = [CCLabel labelWithString:goldenEggNum fontName:@"Arial" fontSize:12];
		goldenEggNumLbl.position = ccp(140,10);
		capacity = [CCLabel labelWithString:[NSString stringWithFormat:@"容量: %@/%@",maxNumOfBirds,topMaxNumOfBirds] fontName:@"Arial" fontSize:12];
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

-(void) updatePlayerInfo
{


}

-(void) updateFriendInfo
{
	
}

-(void) setFriendInfoVisible:(bool) isShow
{
	
}

-(void) showPlayerInfo
{
	
}

-(void) hidePlayerInfo
{
	
}

-(void) showFriendInfo
{
	
}

-(void) hideFriendInfo
{
	
}

@end
