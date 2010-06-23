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

@implementation AnimalStorageManagerContainer
@synthesize title;

-(id) init
{
	if ((self = [super init])) {
		tabDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		tabContentDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_ButtonContainer.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		[bg release];
		tabEnable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"TabButton2.png" ofType:nil] ] ];
		tabDisable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"TabButton1.png" ofType:nil] ] ];

		self.position = ccp(240,160);
//		self.scale = 300.0f/1024.0f;
		self.title = @"仓库";
		[self addTitle];
		
		//根据Tab的名称加载仓库信息
		NSArray *tabArray = [[NSArray alloc] initWithObjects:@"stoAnimals",@"auctionAnimals",nil];
		[self addTab:tabArray];
		for (int i = 0; i< tabArray.count; i++) {
			NSString *tab = [tabArray objectAtIndex:i];
			
			AnimalStorageManagerPanel *buttonContainer = [[AnimalStorageManagerPanel alloc] initWithTab:tab setTarget:self];
			if (i == 0) {
				buttonContainer.position = ccp(self.contentSize.width/2, self.contentSize.height/2 - 50);
			}
			else {
				buttonContainer.position = ccp(2000, self.contentSize.height/2 - 50);
			}
			
			[self addChild:buttonContainer z:7];
			[tabContentDic setObject:buttonContainer forKey:[NSString stringWithFormat:@"tabContent_%d",i]];
		}
		
		//设置一层半透明背景,点击事件的优先级为50,屏蔽下面图层的点击事件
		TransBackground *transBackground = [[TransBackground alloc] initWithPriority:50];
		transBackground.scale = 17.0f;
		transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
		[self addChild:transBackground z:-1];
		
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
			tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:30 setBackground:@"TabButton2.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:49 offsetX:0 offsetY:0 scale:1.0f];
		}
		else {
			tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:30 setBackground:@"TabButton1.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:49 offsetX:0 offsetY:0 scale:1.0f];
		}
		tempTab.position = ccp((rect.size.width + 10) * i + tempTab.contentSize.width/2 + 5 , self.contentSize.height - 90);
		tempTab.tag = i;
		[self addChild:tempTab];
		[tabDic setValue:tempTab forKey:[NSString stringWithFormat:@"tab_%d",i]];
	}
}

//根据点击不同的Tab切换仓库和拍卖来的
-(void)tabHandler:(Button *)button
{
	tabIndex = button.tag;
	[button setTexture:tabEnable];
	AnimalStorageManagerPanel *buttonContainer = [tabContentDic objectForKey:[NSString stringWithFormat:@"tabContent_%d",tabIndex]];
	buttonContainer.position = ccp(self.contentSize.width/2, self.contentSize.height/2 - 50);
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
	
	if(itemButton.itemType ==@"auctionAnimals")
	{
		currentTagFlag = @"auctionAnimals";
		NSString *auctionBirdStorageId = itemButton.itemId;
		
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",auctionBirdStorageId,@"auctionBirdStorageId",nil];
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestaddAuctionAnimalToFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		//itemInfoPane.position = ccp(10000, itemInfoPane.contentSize.height/2);

	}
	else if (itemButton.itemType == @"stoAnimals")
	{
		currentTagFlag = @"stoAnimals";
		NSString *adultBirdStorageId = itemButton.itemId;
		
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmId,@"farmId",adultBirdStorageId,@"adultBirdStorageId",nil];
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestaddAnimalToFarm WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
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
	if(currentTagFlag == @"auctionAnimals")
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
	else if(currentTagFlag == @"stoAnimals")
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

@end
