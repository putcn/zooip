//
//  AnimalStorageManagerContainer.m
//  zoo
//
//  Created by AlexLiu on 6/4/10.
//  Copyright 2010 Vance. All rights reserved.
//

#import "AnimalStorageManagerContainer.h"
#import "Button.h"
#import "ServiceHelper.h"
#import "AnimalStorageManagerPanel.h"
#import "FeedbackDialog.h"
#import "GetAllBirdFarmAnimalInfoController.h"
#import "AnimalController.h"

//动物面板容器
@implementation AnimalStorageManagerContainer
@synthesize title;

-(id) init
{
	if ((self = [super init])) {
		tabDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		tabContentDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_2.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		tabEnable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"tab_press.png" ofType:nil] ] ];
		tabDisable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"tab.png" ofType:nil] ] ];

		CCSprite* bg_2 = [CCSprite spriteWithFile:@"仓库LOGO.png"];
		bg_2.position = ccp(80,205);
		[self addChild:bg_2 z:5 ];
		
		self.position = ccp(240,160);
//		self.scale = 300.0f/1024.0f;
//		self.title = @"仓库";
//		[self addTitle];
		
		//根据Tab的名称加载仓库信息
		NSArray *tabArray = [[NSArray alloc] initWithObjects:@"动物",@"拍来动物",nil];
		AnimalStorageManagerPanel *buttonContainer;
		[self addTab:tabArray];
		for (int i = 0; i< tabArray.count; i++) {
			NSString *tab = [tabArray objectAtIndex:i];
			
			buttonContainer = [[AnimalStorageManagerPanel alloc] initWithTab:tab setTarget:self];
			if (i == 0) {
				buttonContainer.position = ccp(40, 170);
			}
			else {
				buttonContainer.position = ccp(2000, self.contentSize.height/2 - 50);
			}
			
			[self addChild:buttonContainer z:7];
			[tabContentDic setObject:buttonContainer forKey:[NSString stringWithFormat:@"tabContent_%d",i]];
		}
		[buttonContainer release];
		
		//Button *nextPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_右.png" setTarget:self setSelector:@selector(nextPage:) setPriority:40 offsetX:0 offsetY:0 scale:1.0f];
//		Button *forwardPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_左.png" setTarget:self setSelector:@selector(forwardPage:) setPriority:40 offsetX:0 offsetY:0 scale:1.0f];
//		//		forwardPageBtn.flipX = YES;
//		nextPageBtn.position = ccp(self.contentSize.width/2 + 100, 25);
//		forwardPageBtn.position = ccp(self.contentSize.width/2 - 100, 25);
//		[self addChild:nextPageBtn z:7];
//		[self addChild:forwardPageBtn z:7];
		
		Button *statusIcon = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"X.png" setTarget:self
											   setSelector:@selector(OverIconHandler) setPriority:0 offsetX:-1 offsetY:2 scale:1];
		statusIcon.position = ccp(347, 188);
		[self addChild:statusIcon z:7 ];
		[statusIcon release];
		
		//设置一层半透明背景,点击事件的优先级为50,屏蔽下面图层的点击事件
		TransBackground *transBackground = [[TransBackground alloc] initWithPriority:45];
		transBackground.scale = 5.0f;
		transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
		[self addChild:transBackground z:-1];
		[transBackground release];
	}
	return self;
}

//设置标题
-(void)addTitle
{
	NSLog(@"%@",title);
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:30];
	[titleLbl setColor:ccc3(0, 0, 0)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2);
	[self addChild:titleLbl z:10];
}

//添加Tab按钮,点击Tab之后的回调方法为:tabHandler
-(void)addTab:(NSArray*) tabArray
{
	CGRect rect = CGRectZero;
	rect.size = tabEnable.contentSize;
	CCSprite *tempTab;
	for (int i = 0; i < [tabArray count]; i++) {
		NSString *tempString = [tabArray objectAtIndex:i];
		
		if (i == 0) {
			tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:10 setBackground:@"tab_press.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:40 offsetX:0 offsetY:0 scale:1.0f];
		}
		else {
			tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:10 setBackground:@"tab.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:40 offsetX:0 offsetY:0 scale:1.0f];
		}
		tempTab.position = ccp((rect.size.width ) * i + tempTab.contentSize.width + 110 , self.contentSize.height + 5);
		
		tempTab.tag = i;
		[self addChild:tempTab];
		[tabDic setValue:tempTab forKey:[NSString stringWithFormat:@"tab_%d",i]];
	}
	[tempTab release];
}

//根据点击不同的Tab切换仓库和拍卖来的
-(void)tabHandler:(Button *)button
{
	tabIndex = button.tag;
	[button setTexture:tabEnable];
	AnimalStorageManagerPanel *buttonContainer = [tabContentDic objectForKey:[NSString stringWithFormat:@"tabContent_%d",tabIndex]];
	buttonContainer.position = ccp(40,170);
	int tabCount = [tabDic count];
	for (int i = 0; i < tabCount; i++) {
		if (i != tabIndex) {
			AnimalStorageManagerPanel *buttonContainer = [tabContentDic objectForKey:[NSString stringWithFormat:@"tabContent_%d",i]];
			buttonContainer.position = ccp(2000, self.contentSize.height/2 - 50);
			Button *disableButton = [tabDic objectForKey:[NSString stringWithFormat:@"tab_%d",i]];
			[disableButton setTexture:tabDisable];
		}
	}
	

}

//点击不同的动物，放入到动物园
-(void) itemInfoHandler:(AnimalStorageManagerButtonItem *) itemButton
{
	
	//AnimalStorageManagerPanel *itemInfo = (AnimalStorageManagerPanel *)itemButton.target; 
	NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
	
	if(itemButton.itemType ==@"拍来动物")
	{
		currentTagFlag = @"拍来动物";
		NSString *auctionBirdStorageId = itemButton.itemId;
		
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",auctionBirdStorageId,@"auctionBirdStorageId",nil];
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestaddAuctionAnimalToFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		//itemInfoPane.position = ccp(10000, itemInfoPane.contentSize.height/2);
		
		BaseServerController *getAllBirdFarmAnimalInfoController = [[GetAllBirdFarmAnimalInfoController alloc] initWithWorkFlowController:nil];
		[getAllBirdFarmAnimalInfoController execute:nil];
		[[AnimalController sharedAnimalController] clearAnimal];
		[[AnimalController sharedAnimalController] addAnimal:[DataEnvironment sharedDataEnvironment].animalIDs];
		
	}
	else if (itemButton.itemType == @"动物")
	{
		currentTagFlag = @"动物";
		NSString *adultBirdStorageId = itemButton.itemId;
		
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",adultBirdStorageId,@"adultBirdStorageId",nil];
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestaddAnimalToFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		BaseServerController *getAllBirdFarmAnimalInfoController = [[GetAllBirdFarmAnimalInfoController alloc] initWithWorkFlowController:nil];
		[getAllBirdFarmAnimalInfoController execute:nil];
		[[AnimalController sharedAnimalController] clearAnimal];
		[[AnimalController sharedAnimalController] addAnimal:[DataEnvironment sharedDataEnvironment].animalIDs];
	}
}



-(void) cancel:(Button *)button
{
	itemInfoPane.position = ccp(10000, itemInfoPane.contentSize.height/2);
	NSLog(@"取消");
}


-(void) resultCallback:(NSObject *)value
{
	NSDictionary* dic = (NSDictionary*)value;
 	NSInteger code = [[dic objectForKey:@"code"] intValue];
	if(currentTagFlag == @"拍来动物")
	{
		switch (code) {
			case 0:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"找不到拍卖所得动物"];
				break;
			case 1:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"添加动物到饲养场成功"];
				break;
			case 2:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"仓库中没有该动物!"];
				break;
			case 3:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"饲养场动物数量超标!"];
				break;
			default:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作出现异常"];
				break;
		}
	}
	else if(currentTagFlag == @"动物")
	{
		switch (code) {
			case 1:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"添加动物到饲养场成功"];
				break;
			case 2:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"仓库动物数量不足!"];
				break;
			case 3:
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"饲养场动物数量超标!"];
				break;
			default :
				[[FeedbackDialog sharedFeedbackDialog] addMessage:@"操作出现异常"];
				break;
		}
	}
	NSLog(@"操作已成功!");
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

-(void)dealloc
{
	[title release];
	[tabDic release];
	[tabContentDic release];
	
	[tabEnable  release];
	[tabDisable release];
	[itemInfoPane release];
	
	[currentTagFlag  release];	
	[super dealloc];
}

-(void) OverIconHandler
{
	self.position = ccp(1000,1600);
}


@end
