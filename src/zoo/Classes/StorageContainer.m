//
//  StorageContainer.m
//  zoo
//
//  Created by admin on R.O.C. 99/5/27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StorageContainer.h"
#import "Button.h"
#import "StoButtonContainer.h"


@implementation StorageContainer

@synthesize title;

-(id)init
{
	
	if (  (self = [super init] ) ) {
		
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

		NSArray *eggNameArray = [ [NSArray alloc] initWithObjects:@"egg",@"eggs",nil];
		[self addTab:eggNameArray];
		
		for (int i = 0; i< eggNameArray.count; i++) {
			NSString *tab = [eggNameArray objectAtIndex:i];
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
	CCLabel *titleLbl = [CCLabel labelWithString:title fontName:@"Arial" fontSize:40];
	[titleLbl setColor:ccc3(255, 255, 255)];
	titleLbl.position = ccp(self.contentSize.width/2, self.contentSize.height - titleLbl.contentSize.height/2);
	[self addChild:titleLbl z:10];
}


-(void)addTab:(NSArray*) eggNameArray
{
	CGRect rect = CGRectZero;
	rect.size = tabEnable.contentSize;
	
	for (int i = 0; i < [eggNameArray count]; i++) {
		NSString *tempString = [eggNameArray objectAtIndex:i];
		CCSprite *tempTab;
			if (i == 0) {
				tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:30 setBackground:@"TabButton2.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
			}
			else {
				tempTab = [[Button alloc] initWithLabel:tempString setColor:ccc3(0, 0, 0) setFont:@"Arial" setSize:30 setBackground:@"TabButton1.png" setTarget:self setSelector:@selector(tabHandler:) setPriority:0 offsetX:0 offsetY:0 scale:1.0f];
			}
		tempTab.position = ccp((rect.size.width + 10) * i + tempTab.contentSize.width/2+5 , self.contentSize.height - 80);
		//tempTab.position = ccp((rect.size.width + 10) * i + tempTab.contentSize.width/2 + 5 , self.contentSize.height - 90);
		tempTab.tag = i;
		[self addChild:tempTab];
		[tabDic setValue:tempTab forKey:[NSString stringWithFormat:@"tab_%d",i]];
	}

}// end  addTab function



-(void)tabHandler:(Button *)button
{
	tabIndex = button.tag;
	[button setTexture:tabEnable];
	StoButtonContainer	*buttonContainer = [tabContentDic objectForKey:[NSString stringWithFormat:@"tabContent_%d",tabIndex]];
	buttonContainer.position = ccp(self.contentSize.width/2, self.contentSize.height/2 - 50);
	int tabCount = [tabDic count];
	for (int i = 0; i < tabCount; i++) {
		if (i != tabIndex) {
			StoButtonContainer	*buttonContainer = [tabContentDic objectForKey:[NSString stringWithFormat:@"tabContent_%d",i]];
			buttonContainer.position = ccp(2000, self.contentSize.height/2 - 50);
			Button *disableButton = [tabDic objectForKey:[NSString stringWithFormat:@"tab_%d",i]];
			[disableButton setTexture:tabDisable];
		}
	}
}



-(void) itemInfoHandler:(ItemButton *) itemButton
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

-(void) buyItem:(Button *)button
{
	if ([button.params objectForKey:@"itemType"] == @"egg") {
		if ([[button.params objectForKey:@"itemBuyType"] intValue] == 0) {
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",[button.params objectForKey:@"itemId"],@"originalAnimalId",@"1",@"amount",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyAnimalByGoldenEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			
		}
		else if([[button.params objectForKey:@"itemBuyType"] intValue] == 1){
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",[button.params objectForKey:@"itemId"],@"originalAnimalId",@"1",@"amount",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyAnimalByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			
		}
	}
	else if([button.params objectForKey:@"itemType"] == @"eggs"){
		if ([[button.params objectForKey:@"itemBuyType"] intValue] == 0) {
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",farmId,@"farmId",[button.params objectForKey:@"itemId"],@"foodId",@"1000",@"numOfFood",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyFoodByGoldenEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		else if([[button.params objectForKey:@"itemBuyType"] intValue]== 1){
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSString *farmId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",farmId,@"farmId",[button.params objectForKey:@"itemId"],@"foodId",@"1000",@"numOfFood",nil];
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestbuyFoodByAnts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
	}
	
	
	itemInfoPane.position = ccp(2000, itemInfoPane.contentSize.height/2);
	
}

-(void) cancel:(Button *)button
{
	itemInfoPane.position = ccp(2000, itemInfoPane.contentSize.height/2);
	NSLog(@"取消");
}


-(void) resultCallback:(NSObject *)value
{
	NSLog(@"出售成功");
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

@end