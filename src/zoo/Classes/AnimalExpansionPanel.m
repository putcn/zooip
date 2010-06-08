//
//  AnimalExpansionPanel.m
//  zoo
//
//  Created by AlexLiu on 6/8/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import "AnimalExpansionPanel.h"
#import "TransBackground.h"
#import "ScalerPane.h"
#import "DataModelFarmerInfo.h"
#import "DataModelFarmInfo.h"
#import "DataEnvironment.h"
#import "ModelLocator.h"
#import "ServiceHelper.h"
#import "FeedbackDialog.h"

@implementation AnimalExpansionPanel
@synthesize 
title,
itemId,
itemType,
itemBuyType,
count,
paramsDict;

-(id)initWithParam:(NSDictionary *)param setTarget:(id)target
{
	if((self =[super init]))
	{
		thisTarget = target;
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ItemInfoPane.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		
		self.position = ccp(240,160);
		self.scale = 300.0f/1024.0f;
		self.title = @"扩容";
		[self addTitle];
		//self.title = @"动物配对";
		//[self GetAllLevelUpRequirementInfo];
		NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",nil];
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestexpansionInfo WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackInfo:" AndFailedSel:@"faultCallback:"];
		
		priceLbl = [[CCLabel alloc] retain];
		
		//****[self updateInfo:itId type:itType setTarget:target];
	}
	return self;
}
-(void)addTitle
{
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:30];
	[titleLbl setColor:ccc3(255, 255, 255)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2);
	[self addChild:titleLbl z:10];
}

-(void)GetAllLevelUpRequirementInfo
{
	NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",nil];
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestexpansionInfo WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallbackInfo:" AndFailedSel:@"faultCallback:"];
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

-(void) resultCallbackInfo:(NSObject *)value
{
	NSDictionary* dic = (NSDictionary*)value;
 	NSInteger code = [[dic objectForKey:@"code"] intValue];
	goldenEgg = [[dic objectForKey:@"goldenEgg"] intValue];
	levelRequire = [[dic objectForKey:@"levelRequire"] intValue];
	
	switch (code) {
		case 0:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"农场不存在"];
			break;
		case 1:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"级别不足"];
			break;
		case 2:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"取得正确数据!"];
			break;
		default:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作出现异常"];
			break;
			
	}
	
	[self updateButtonsAndRates];
	
	NSLog(@"操作已成功!");
}

-(void)updateButtonsAndRates
{
	DataModelFarmInfo *farmInfo = (DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo;
	DataModelFarmerInfo *farmerInfo = (DataModelFarmerInfo *)[DataEnvironment sharedDataEnvironment].playerFarmerInfo;

	NSString *animalNum = [NSString stringWithFormat:@"%d",[[DataEnvironment sharedDataEnvironment].animalIDs count]];

	if ([[ModelLocator sharedModelLocator] getIsSelfZoo]) {
		level = [NSString stringWithFormat:@"%d", farmInfo.farm_level];
		maxNumOfBirds = [NSString stringWithFormat:@"%d", farmInfo.farm_maxNumOfBirds];
		goldenEggNum = [NSString stringWithFormat:@"%d", farmerInfo.goldenEgg];
	}else {
		level = [NSString stringWithFormat:@"%d", farmInfo.farm_level];
		maxNumOfBirds = @"unknown";
		goldenEggNum = @"unknown";
	}
	levelLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"%@ 级",level] fontName:@"Arial" fontSize:12];
	levelLbl.position = ccp(self.contentSize.width/2, 400);
	[levelLbl setColor:ccc3(255, 0, 255)];
	levelLbl.scale = 1.5f;

	
	goldenEggNumLbl = [CCLabel labelWithString:goldenEggNum fontName:@"Arial" fontSize:12];
	goldenEggNumLbl.position = ccp(self.contentSize.width/2,340);
	[goldenEggNumLbl setColor:ccc3(255, 0, 255)];
	goldenEggNumLbl.scale = 1.5f;
	
	capacity = [CCLabel labelWithString:[NSString stringWithFormat:@"容量: %@",maxNumOfBirds] fontName:@"Arial" fontSize:12];
	capacity.position = ccp(self.contentSize.width/2 ,280);
	[capacity setColor:ccc3(255, 0, 255)];
	capacity.scale = 1.5f;
	
	requireGoldenEggLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"扩容需要金蛋数量:%d",goldenEgg] fontName:@"Arial" fontSize:12];
	requireGoldenEggLbl.position = ccp(self.contentSize.width/2,220);
	[requireGoldenEggLbl setColor:ccc3(255, 0, 255)];
	requireGoldenEggLbl.scale = 1.5f;
	
	requireLevelLbl = [CCLabel labelWithString:[NSString stringWithFormat:@"扩容需要等级:%d",levelRequire] fontName:@"Arial" fontSize:12];
	requireLevelLbl.position = ccp(self.contentSize.width/2, 160);
	[requireLevelLbl setColor:ccc3(255, 0, 255)];
	requireLevelLbl.scale = 1.5f;
	
	[self addChild:levelLbl z:10];
	[self addChild:goldenEggNumLbl z:10];
	[self addChild:capacity z:10];
	[self addChild:requireLevelLbl z:10];
	[self addChild:requireGoldenEggLbl z:10];
	
	Button *confirmBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:20 setBackground:@"Confirm.png" setTarget:thisTarget setSelector:@selector(levelupConfirm:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
	Button *cancelBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:20 setBackground:@"Cancel.png" setTarget:thisTarget setSelector:@selector(levelCancle:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
	
	//为Button绑定购买的对象,最终传入到[ManageContainer buyItem]中作为参数发送到服务端
	confirmBtn.target = self;
	confirmBtn.position = ccp(self.contentSize.width/2 - 200, 100);
	cancelBtn.position = ccp(self.contentSize.width/2 + 200, 100);
	[self addChild:confirmBtn z:10];
	[self addChild:cancelBtn z:10];

	TransBackground *transBackground = [[TransBackground alloc] initWithPriority:1];
	transBackground.scale = 17.0f;
	transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
	[self addChild:transBackground z:5];
	
	//[self setImg:@"" setBuyType:@"" setPrice:@"1"];
}




-(void) setImg: (NSString *) imagePath setBuyType: (NSString *) buyType setPrice:(NSString *) price
{
	CCSprite *item = [CCSprite node];
	CCTexture2D *itemImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:imagePath ofType:nil] ] ];
	CGRect rect = CGRectZero;
	rect.size = itemImg.contentSize;
	[item setTexture: itemImg];
	[item setTextureRect: rect];
	item.scale = 2.0f;
	[itemImg release];
	CCSprite *buyImg;
	if (buyType == @"goldEgg") {
		buyImg = [CCSprite spriteWithFile:@"goldegg.png"];
	}
	else {
		buyImg = [CCSprite spriteWithFile:@"goldant.png"];
	}
	priceLbl = [CCLabel labelWithString:price fontName:@"Arial" fontSize:20];
	[priceLbl setColor:ccc3(255, 0, 255)];
	
	item.position = ccp(item.contentSize.width/2 + 150, self.contentSize.height  - item.contentSize.height /2 - 150);
	buyImg.position = ccp(item.position.x - 60, 300);
	priceLbl.position = ccp(item.position.x + 20 , 300);
	buyImg.scale = 1.5f;
	priceLbl.scale = 1.5f;
	
	//[self addChild:item z:7];
	//[self addChild:buyImg z:7];
	[self addChild:priceLbl z:7];
}							  


-(void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end
