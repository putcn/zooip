//
//  StorageContainer.m
//  zoo
//
//  Created by admin on R.O.C. 99/5/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Button.h"
#import "SellitemButton.h"
#import "StoButtonContainer.h"
#import "StorageContainer.h"
#import "FeedbackDialog.h";




@implementation StorageContainer

@synthesize title;

-(id) init
{
	if ((self = [super init])) {
		tabDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		tabContentDic = [[NSMutableDictionary alloc] initWithCapacity:0];
		tabEnable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"TabButton2.png" ofType:nil] ] ];
		tabDisable = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"TabButton1.png" ofType:nil] ] ];
		CCTexture2D *bg = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ManageContainer.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture:bg];
		[self setTextureRect: rect];
		self.position = ccp(240,160);
		self.scale = 300.0f/1024.0f;
		self.title = @"仓库";
		[self addTitle];
		NSArray *tabArray = [[NSArray alloc] initWithObjects:@"egg",@"zygoteegg",nil];
		[self addTab:tabArray];
		for (int i = 0; i< tabArray.count; i++) {
			NSString *tab = [tabArray objectAtIndex:i];
			StoButtonContainer *buttonContainer = [[StoButtonContainer alloc] initWithTab:tab setTarget:self];
			if (i == 0) {
				buttonContainer.position = ccp(self.contentSize.width/2, self.contentSize.height/2 - 50);
			}
			else {
				buttonContainer.position = ccp(2000, self.contentSize.height/2 - 50);
			}
			
			[self addChild:buttonContainer z:7];
			[tabContentDic setObject:buttonContainer forKey:[NSString stringWithFormat:@"tabContent_%d",i]];
		}
		
	}
	return self;
}


-(void)addTitle
{
	NSLog(@"%@",title);
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
			tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:30 setBackground:@"TabButton2.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:2 offsetX:0 offsetY:0 scale:1.0f];
		}
		else {
			tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:30 setBackground:@"TabButton1.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:2 offsetX:0 offsetY:0 scale:1.0f];
		}
		tempTab.position = ccp((rect.size.width + 10) * i + tempTab.contentSize.width/2 + 5 , self.contentSize.height - 90);
		tempTab.tag = i;
		[self addChild:tempTab];
		[tabDic setValue:tempTab forKey:[NSString stringWithFormat:@"tab_%d",i]];
	}
}


-(void)tabHandler:(Button *)button
{
	tabIndex = button.tag;
	[button setTexture:tabEnable];
	SellitemButton	*buttonContainer = [tabContentDic objectForKey:[NSString stringWithFormat:@"tabContent_%d",tabIndex]];
	buttonContainer.position = ccp(self.contentSize.width/2, self.contentSize.height/2 - 50);
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



/*
 ZooNetworkRequesttoSellZygoteEgg,
 ZooNetworkRequesttoSellProduct,
 ZooNetworkRequesttoSellAllZygoteEgg,
 ZooNetworkRequesttoSellAllProducts,
 
 */

-(void) buyItem:(Button *)button
{
	
	
	SellinfoPane *itemInfo = (SellinfoPane *)button.target; 

	
	if (itemInfo.itemType == @"egg") {
		
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			DataModelStorageEgg *storageEgg = (DataModelStorageEgg *)[[DataEnvironment sharedDataEnvironment].storageEggs objectForKey:itemInfo.itemId];

			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",storageEgg.eggId,@"eggId",[NSString stringWithFormat:@"%d",itemInfo.count],@"amount",nil];
	
			
			//NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"A6215BF61A3AF50A8F72F043A1A6A85C",@"farmerId",storageEgg.eggId,@"eggId",[NSString stringWithFormat:@"%d",itemInfo.count],@"amount",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoSellProduct WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
				
		
	
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
		
		
}






-(void) cancelHandler:(Button *)button
{
	
	eggHatchInfoPane.position = ccp(10000, eggHatchInfoPane.contentSize.height/2);
	
}




-(void) cancel:(Button *)button
{
	itemInfoPane.position = ccp(10000, itemInfoPane.contentSize.height/2);
	NSLog(@"取消");
}


-(void) resultCallback:(NSObject *)value
{
	[[FeedbackDialog sharedFeedbackDialog] addMessage:@"恭喜你出售成功!"];

	NSLog(@"操作已成功!");
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

@end
