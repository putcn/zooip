//
//  ManageContainer.m
//  zoo
//
//  Created by Rainbow on 5/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//  
//  进入商店界面 

#import "ManageContainer.h"
#import "Button.h"
#import "ButtonContainer.h"
#import "FeedbackDialog.h"
#import "Button.h"

@implementation ManageContainer

@synthesize title;

-(id) init
{
	if ((self = [super init])) {
		tabDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		tabContentDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		tabEnable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"tab_press.png" ofType:nil] ] ];
		tabDisable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"tab.png" ofType:nil] ] ];
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_2.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		
		CCSprite* bg_2 = [CCSprite spriteWithFile:@"store_logo.png"];
		bg_2.position = ccp(60,205);
		[self addChild:bg_2 z:5 ];
		
		Button *statusIcon = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"X.png" setTarget:self
											   setSelector:@selector(OverIconHandler) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
		statusIcon.position = ccp(350, 0);
		[self addChild:statusIcon z:5 ];
		[statusIcon release];
		
		self.position = ccp(240,160);
//		self.scale = 300.0f/1024.0f;
//		self.title = @"商店";
//		[self addTitle];
		
		//根据Tab的名称加载商店信息
		NSArray *tabArray = [[NSArray alloc] initWithObjects:@"animal",@"food",@"goods",nil];
		[self addTab:tabArray];
		for (int i = 0; i< tabArray.count; i++) {
			NSString *tab = [tabArray objectAtIndex:i];
			ButtonContainer *buttonContainer = [[ButtonContainer alloc] initWithTab:tab setTarget:self];
			if (i == 0) {
				buttonContainer.position = ccp(40, 170);
			}
			else {
				buttonContainer.position = ccp(2000, self.contentSize.height/2 - 50);
			}

			[self addChild:buttonContainer z:7];
			[tabContentDic setObject:buttonContainer forKey:[NSString stringWithFormat:@"tabContent_%d",i]];
		}
		
		//设置一层半透明背景,点击事件的优先级为50,屏蔽下面图层的点击事件
//		TransBackground *transBackground = [[TransBackground alloc] initWithPriority:50];
//		transBackground.scale = 17.0f;
//		transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
//		[self addChild:transBackground z:-1];
		
	}
	return self;
}

//设置标题
-(void)addTitle
{
	NSLog(@"%@",title);
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:30];
	[titleLbl setColor:ccc3(255, 255, 255)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2);
	[self addChild:titleLbl z:10];
}

//添加Tab按钮,点击Tab之后的回调方法为:tabHandler
-(void)addTab:(NSArray*) tabArray
{
	CGRect rect = CGRectZero;
	rect.size = tabEnable.contentSize;
	for (int i = 0; i < [tabArray count]; i++) {
		NSString *tempString = [tabArray objectAtIndex:i];
		CCSprite *tempTab;
		if (i == 0) {
			tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:20 setBackground:@"tab_press.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:49 offsetX:0 offsetY:0 scale:1.0f];
		}
		else {
			tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:20 setBackground:@"tab.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:49 offsetX:0 offsetY:0 scale:1.0f];
		}
		tempTab.position = ccp((rect.size.width) * i + tempTab.contentSize.width + 70 , self.contentSize.height+5);
		tempTab.tag = i;
		[self addChild:tempTab];
		[tabDic setValue:tempTab forKey:[NSString stringWithFormat:@"tab_%d",i]];
	}
}
 
//根据点击不同的Tab切换商店的内容
-(void)tabHandler:(Button *)button
{
	tabIndex = button.tag;
	[button setTexture:tabEnable];
	ButtonContainer	*buttonContainer = [tabContentDic objectForKey:[NSString stringWithFormat:@"tabContent_%d",tabIndex]];
	buttonContainer.position = ccp(40, 170);
	int tabCount = [tabDic count];
	for (int i = 0; i < tabCount; i++) {
		if (i != tabIndex) {
			ButtonContainer	*buttonContainer = [tabContentDic objectForKey:[NSString stringWithFormat:@"tabContent_%d",i]];
			buttonContainer.position = ccp(2000, self.contentSize.height/2 - 50);
			Button *disableButton = [tabDic objectForKey:[NSString stringWithFormat:@"tab_%d",i]];
			[disableButton setTexture:tabDisable];
		}
	}
}

//点击不同的物品之后,弹出不同的物品信息
-(void) itemInfoHandler:(ItemButton *) itemButton
{
	//判断是否首次加载物品信息框
	if (itemInfoPane == nil) {
		itemInfoPane = [[ItemInfoPane alloc] initWithItem:itemButton.itemId type:itemButton.itemType setTarget:self];
		itemInfoPane.position = ccp(self.contentSize.width/2, itemInfoPane.contentSize.height/2);
		[self addChild:itemInfoPane z:20];
	}
	else {		
		[itemInfoPane updateInfo:itemButton.itemId type:itemButton.itemType setTarget:self];
		itemInfoPane.position = ccp(self.contentSize.width/2, itemInfoPane.contentSize.height/2);
	}

}


//点击购买物品之后回调此方法
-(void) buyItem:(Button *)button
{
	//获取从Button回调的参数,强制转换为ItemInfoPane对象,改对象携带了购买物品所需要的所有参数
	ItemInfoPane *itemInfo = (ItemInfoPane *)button.target; 
	if (itemInfo.itemType == @"animal") {
		if (itemInfo.itemBuyType == @"goldEgg") {
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",itemInfo.itemId,@"originalAnimalId",[NSString stringWithFormat:@"%d",itemInfo.count],@"amount",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyAnimalByGoldenEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];

			
		}
		else if(itemInfo.itemBuyType == @"ant"){
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",itemInfo.itemId,@"originalAnimalId",[NSString stringWithFormat:@"%d",itemInfo.count],@"amount",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyAnimalByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
						
		}
	}
	else if(itemInfo.itemType == @"food"){
		if (itemInfo.itemBuyType == @"goldEgg") {
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",farmId,@"farmId",itemInfo.itemId,@"foodId",@"10000",@"numOfFood",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyFoodByGoldenEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		else if(itemInfo.itemBuyType == @"ant"){
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",farmId,@"farmId",itemInfo.itemId,@"foodId",[NSString stringWithFormat:@"%d",itemInfo.count],@"numOfFood",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyFoodByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
	}
	else if(itemInfo.itemType == @"goods"){
		if (itemInfo.itemId = @"1") {
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",itemInfo.itemId,@"goodsId",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyDogByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		else if(itemInfo.itemId== @"2"){
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",itemInfo.itemId,@"goodsId",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyTurtleByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];			
		}
	}

	itemInfoPane.position = ccp(10000, itemInfoPane.contentSize.height/2);
	[itemInfo release];
	
}

-(void) cancel:(Button *)button
{
	itemInfoPane.position = ccp(10000, itemInfoPane.contentSize.height/2);
	NSLog(@"取消");
}


-(void) resultCallback:(NSObject *)value
{
	[[FeedbackDialog sharedFeedbackDialog] addMessage:@"恭喜你购买物品成功!"];
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}


-(void) OverIconHandler
{
	self.position = ccp(1000,160);
}


@end
















