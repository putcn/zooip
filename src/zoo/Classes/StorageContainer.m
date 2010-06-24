//
//  StorageContainer.m
//  zoo
//
//  Created by admin on R.O.C. 99/5/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Button.h"
#import "SellitemButton.h"
#import "StorageContainer.h"
#import "FeedbackDialog.h"


@implementation StorageContainer

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
		self.position = ccp(240,160);
//		self.scale = 300.0f/1024.0f;
//		self.title = @"仓库";
		
		CCSprite* bg_2 = [CCSprite spriteWithFile:@"depot_logo.png"];
		bg_2.position = ccp(75,205);
		[self addChild:bg_2 z:5 ];
		
		Button *statusIcon = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"X.png" setTarget:self
											   setSelector:@selector(OverIconHandler) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
		statusIcon.position = ccp(350, 6);
		[self addChild:statusIcon z:5 ];
		[statusIcon release];
		
		num_paneNum = [ [NSMutableArray alloc] init];
		
		[self addTitle];
		[self addMainPanel];
		
		//设置一层半透明背景,点击事件的优先级为50,屏蔽下面图层的点击事件
//		TransBackground *transBackground = [[TransBackground alloc] initWithPriority:50];
//		transBackground.scale = 17.0f;
//		transBackground.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
//		[self addChild:transBackground z:-1];
		
		[num_paneNum release];
		
	}
	return self;
}



-(void)addMainPanel
{
	
	NSArray *tabArray = [[NSArray alloc] initWithObjects:@"egg",@"zygoteegg",nil];
	[self addTab:tabArray];		
	
	if (onePane == nil || twoPane == nil) {
		NSString *tab1 = [tabArray objectAtIndex:0];
		NSString *tab2 = [tabArray objectAtIndex:1];
		onePane = [[StoButtonContainer alloc] initWithTab:tab1 setTarget:self];
//		onePane.position = ccp(self.contentSize.width/2, self.contentSize.height/2 - 50);

		
		onePane.position = ccp(40, 170);

		twoPane = [[StoButtonContainer alloc] initWithTab:tab2 setTarget:self];
		twoPane.position = ccp(2000, self.contentSize.height/2 - 50);
		
		[tabContentDic setObject:onePane forKey:[NSString stringWithFormat:@"tabContent_%d",0]];
		[tabContentDic setObject:twoPane forKey:[NSString stringWithFormat:@"tabContent_%d",1]];
		
		[self addChild:onePane z:7];
		[self addChild:twoPane z:7];
	}
	
	Button *sellAllBtn = [[Button alloc] initWithLabel:@"全部卖出" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:18 setBackground:@"TabButton2.png" setTarget:self setSelector:@selector(sellAllEggsHandler:) setPriority:1 offsetX:0 offsetY:0 scale:2.0f];
	sellAllBtn.position = ccp(self.contentSize.width/2 +400, 80);
	[self addChild:sellAllBtn z:7];
	
}



-(void)addTitle
{
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:30];
	[titleLbl setColor:ccc3(255, 255, 255)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2);
	[self addChild:titleLbl z:10];
}

-(void)addTab:(NSArray*) tabArray
{
	CGRect rect = CGRectZero;
	rect.size = tabEnable.contentSize;
	
	for (int i = 0; i < [tabArray count]; i++) {
		NSString *tempString = [tabArray objectAtIndex:i];
		CCSprite *tempTab;
		if (i == 0) {
			tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:20 setBackground:@"tab_press.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:2 offsetX:0 offsetY:0 scale:1.0f];
		}
		else {
			tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:15 setBackground:@"tab.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:2 offsetX:0 offsetY:0 scale:1.0f];
		}
		tempTab.position = ccp((rect.size.width) * i + tempTab.contentSize.width + 110 , self.contentSize.height+5);
		tempTab.tag = i;
		[self addChild:tempTab];
		[tabDic setValue:tempTab forKey:[NSString stringWithFormat:@"tab_%d",i]];
	}
}


-(void)tabHandler:(Button *)button
{
	tabIndex = button.tag;
	[button setTexture:tabEnable];
	
	if (tabIndex == 0) {
		testType = @"egg";
	}else {
		testType = @"zygoteegg";
	}

	SellitemButton	*buttonContainer = [tabContentDic objectForKey:[NSString stringWithFormat:@"tabContent_%d",tabIndex]];
	buttonContainer.position = ccp(40,170);
	int tabCount = [tabDic count];
	for (int i = 0; i < tabCount; i++) {
		if (i != tabIndex) {
			SellitemButton	*buttonContainer = [tabContentDic objectForKey:[NSString stringWithFormat:@"tabContent_%d",i]];
			buttonContainer.position = ccp(2000, self.contentSize.height/2 - 50);
			Button *disableButton = [tabDic objectForKey:[NSString stringWithFormat:@"tab_%d",i]];
			[disableButton setTexture:tabDisable];
		}
	}
}

-(void) itemInfoHandler:(SellitemButton *) itemButton
{
	
	curr_itemId   = itemButton.itemId;
	curr_itemType = itemButton.itemType;
	curr_target   = self;
	
	if (itemInfoPane == nil) {
		
		itemInfoPane = [[SellinfoPane alloc] initWithItem:itemButton.itemId type:itemButton.itemType setTarget:self];
		itemInfoPane.position = ccp(self.contentSize.width/2, itemInfoPane.contentSize.height/2);
		[self addChild:itemInfoPane z:20];
	}
	else {
		
		[itemInfoPane updateInfo:itemButton.itemId type:itemButton.itemType setTarget:self];
		itemInfoPane.position = ccp(self.contentSize.width/2, itemInfoPane.contentSize.height/2);
	}
	
}




-(void) sellEggItem:(Button *)button
{
	
	SellinfoPane *itemInfo = (SellinfoPane *)button.target; 
	
	if (itemInfo.itemType == @"egg") {
		
		
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			
			DataModelStorageEgg *storageEgg = (DataModelStorageEgg *)[[DataEnvironment sharedDataEnvironment].storageEggs objectForKey:itemInfo.itemId];

			if (itemInfo.count == 0) {
				NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",storageEgg.eggId,@"eggId",[NSString stringWithFormat:@"%d",1],@"amount",nil];
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoSellProduct WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
				
			}else{
				NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",storageEgg.eggId,@"eggId",[NSString stringWithFormat:@"%d",itemInfo.count],@"amount",nil];
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoSellProduct WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
				
			}
			
		
	}//end if
	
	
	if(itemInfo.itemType == @"zygoteegg"){
		
		NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
		
		DataModelStorageZygoteEgg *storageZyEggModel = (DataModelStorageZygoteEgg *)[[DataEnvironment sharedDataEnvironment].storageZygoteEggs objectForKey:itemInfo.itemId];
				
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",storageZyEggModel.zygoteStorageId,@"zygoteStorageId",nil];
		
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoSellZygoteEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
				
					
	}
		
	
	itemInfoPane.position = ccp(10000, itemInfoPane.contentSize.height/2);
	[itemInfo release];
	
	
}




//hatch egg handler

-(void) hatchHandler:(Button *)button
{
		SellinfoPane *itemInfo = (SellinfoPane *)button.target; 
						
		NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
		
		NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
		
		DataModelStorageZygoteEgg *storageZyEggModel = (DataModelStorageZygoteEgg *)[[DataEnvironment sharedDataEnvironment].storageZygoteEggs objectForKey:itemInfo.itemId];
				
		eggHatchInfoPane = [[EggHatchInfoPane alloc] initWithItem:farmerId farmID:farmId storageZyID:storageZyEggModel.zygoteStorageId setTarget:self];
		
		eggHatchInfoPane.position = ccp(self.contentSize.width/2, itemInfoPane.contentSize.height/2 - 50);
		[self addChild:eggHatchInfoPane z:20];
		
		[itemInfo release];
}


-(void) cancelHandler:(Button *)button
{
	//刷新孵化界面
	[self updadaPane];
	eggHatchInfoPane.position = ccp(10000, eggHatchInfoPane.contentSize.height/2);
	
}



-(void) cancel:(Button *)button
{
	itemInfoPane.position = ccp(10000, itemInfoPane.contentSize.height/2);

}


//出售单个卵成功
-(void) resultCallback:(NSObject *)value
{
	[[FeedbackDialog sharedFeedbackDialog] addMessage:@"恭喜你出售成功!"];
	
	//刷新界面
	[self updadaPane];
	
	NSLog(@"操作已成功!");
}


//sell all eggs
-(void) sellAllEggsHandler:(Button *)button
{
	
		
	if (testType==nil) {
		testType = @"egg";
	}
	
	
	if (testType == @"egg") {
		
		NSString *par = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;

		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:par,@"farmerId",nil];
		
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoSellAllProducts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultAllEggCallback:" AndFailedSel:@"faultCallback:"];
		
	}
	if(testType == @"zygoteegg")
	{
		
		NSString *par = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:par,@"farmerId",nil];
		
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoSellAllProducts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultAllEggCallback:" AndFailedSel:@"faultCallback:"];
		
		
	}	
	
}



-(void) resultAllEggCallback:(NSObject *)value
{
	
	NSDictionary *result = (NSDictionary *)value;
	
	NSInteger code = [[result objectForKey:@"code"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"code"] intValue];
	
	if (code == 0) {
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"没有可卖的蛋!"];
	}
	
	if (code == 1) {
		//刷新界面
		[self updadaPane];
		
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"成功卖出所有蛋!"];
	}
	
	
}



-(void) faultCallback:(NSObject *)value
{
	[[FeedbackDialog sharedFeedbackDialog] addMessage:@"Server Connection Fail!"];
}



-(void) updadaPane
{
	
	[onePane upData];
	[twoPane upData];		
	
}


-(void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	
	[title            release];
	[tabDic           release];
	[tabContentDic    release];
	[tabEnable        release];
	[tabDisable       release];
	[itemInfoPane     release];
	[eggHatchInfoPane release];
	[buttonContainer  release];
	[onePane          release];
	[twoPane          release];
	[curr_itemId      release];
	[curr_itemType    release];
	[testType         release];
	[isEggEmpty       release];
	[num_paneNum      release];
	[curr_target      release];
	[super dealloc];
}


-(void) OverIconHandler
{
	self.position = ccp(1000,160);
}




@end
