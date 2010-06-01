//
//  StoButtonContainer.m
//  zoo
//
//  Created by admin on R.O.C. 99/5/28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StoButtonContainer.h"


@implementation StoButtonContainer

-(id) initWithTab: (NSString *)tabName setTarget:(id)target
{
	if ((self = [super init])) {
		parentTarget = target;
		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ButtonContainer.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture: bg];
		[self setTextureRect: rect];
		[bg release];
		tabFlag = tabName;
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"A6215BF61A3AF50A8F72F043A1A6A85C",@"farmerId",nil];
		if (tabFlag == @"egg") {
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageProducts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		else if(tabFlag == @"eggs"){
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageZygoteEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		
		
		//Button *nextPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(nextPage:) setPriority:1 offsetX:0 offsetY:0 scale:1.0f];
		//Button *forwardPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(forwardPage:) setPriority:1 offsetX:0 offsetY:0 scale:1.0f];
		//forwardPageBtn.flipX = YES;
		//nextPageBtn.position = ccp(self.contentSize.width/2 + 100, 0);
		//forwardPageBtn.position = ccp(self.contentSize.width/2 - 100, 0);
		//[self addChild:nextPageBtn z:7];
		//[self addChild:forwardPageBtn z:7];
	}
	return self;
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *itemDic;
	NSArray *itemArray;
	
	
	if (tabFlag == @"egg") {
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageEggs;
		itemArray = [itemDic allKeys];
	}
	else if(tabFlag == @"eggs")
	{
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageZygoteEggs;
		itemArray = [itemDic allKeys];
	}
	
	totalPage = itemArray.count/12 + 1;
	currentPageNum = 1;
	[self generatePage];
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

-(void) nextPage:(Button *)button
{
	if ( currentPageNum + 1 <= totalPage) {
		for (int i = 0; i< currentNum; i ++) {
			[self removeChildByTag:i cleanup:YES];
		}
		
		currentPageNum = currentPageNum + 1;
		[self generatePage];
	}
}

-(void) forwardPage:(Button *)button
{
	if (currentPageNum - 1 > 0) {
		for (int i = 0; i< currentNum; i ++) {
			[self removeChildByTag:i cleanup:YES];
		}
		
		currentPageNum = currentPageNum - 1;
		[self generatePage];
	}
}

-(void) generatePage
{
	if (tabFlag == @"egg") {
		NSDictionary *storageEggDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageEggs;
		
		//DataModelStorageEgg
		DataModelStorageEgg *storageEgg;
		NSArray *eggsArray = [storageEggDic allKeys];
		int endNumber = currentPageNum * 12;
		if (endNumber >= eggsArray.count) {
			endNumber = eggsArray.count;
			
		}
		
		currentNum = endNumber - (currentPageNum -1 ) *12 ;
		for (int i = (currentPageNum -1)*12; i < endNumber; i ++) {
			storageEgg = [storageEggDic objectForKey:[eggsArray objectAtIndex:i]];
			
			//NSString *price = [NSString stringWithFormat:@"%d",storageEgg.eggPrice];

			NSString *picName = [NSString stringWithFormat:@"%@",storageEgg.eggNameEN];
			NSString *eggName = [NSString stringWithFormat:@"%@",storageEgg.eggNameEN];
			NSString *eggTotal = [NSString stringWithFormat:@" 55"];
			NSArray *eNameArr = [picName componentsSeparatedByString:@" "];
			
			//NSLog(@"   ==============eggname  size------>>>>>>>>>>>>>>>>>> %@",[eNameArr objectAtIndex:0]);			
			
			
			//NSString *picFileName = [NSString stringWithFormat:@"%@Egg.png",[eNameArr objectAtIndex:0] ];
						
			//SellitemButton *itemButton = [[SellitemButton alloc] initWithItem:storageEgg.eggId setitType:tabFlag setImagePath:picFileName setBuyType:buyType setPrice:price setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
			//SellitemButton *itemButton = [[SellitemButton alloc] initWithItem:storageEgg.eggId setitType:tabFlag setImagePath:picFileName setEggTotal:eggTotal setEggName:eggName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];

			
			//itemButton.position = ccp(225 * (i%4) + 120, self.contentSize.height - 180 * ((i-12*(currentPageNum-1))/4) - 100);
			
			//[self addChild:itemButton z:7 tag:i%12];
		}
	}
	else if (tabFlag == @"eggs"){
	/*	NSDictionary *storageZygoteEggsDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageZygoteEggs;
		DataModelStorageZygoteEgg *dataModelStorageZygoteEggs;
		NSArray *zygoteEggsArray = [storageZygoteEggsDic allKeys];
		int endNumber = currentPageNum * 12;
		if (endNumber >= zygoteEggsArray.count) {
			endNumber = zygoteEggsArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *12 ;
		for (int i = (currentPageNum -1)*12; i < endNumber; i ++) {
			dataModelStorageZygoteEggs = [storageZygoteEggsDic objectForKey:[zygoteEggsArray objectAtIndex:i]];
			
			int buyType = 0;
			NSString *price = [NSString stringWithFormat:@"%d",dataModelStorageZygoteEggs.eggPrice];
			
			
			if (dataModelFood.antsRequired > 0) {
				buyType = 1;
				price = [NSString stringWithFormat:@"%d",dataModelFood.antsRequired];
			}
			 
			 */
			/*
			NSString *picName = [NSString stringWithFormat:@"%@",dataModelStorageZygoteEggs.eggNameEN];
			NSArray *eNameArr = [picName componentsSeparatedByString:@" "];
			
			
			NSString *picFileName = [NSString stringWithFormat:@"%@Egg.png",[eNameArr objectAtIndex:0]];
			
			SellitemButton *itemButton = [[SellitemButton alloc] initWithItem:dataModelStorageZygoteEggs.eggId setitType:tabFlag setImagePath:picFileName setBuyType:buyType setPrice:price setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
			
			itemButton.position = ccp(225 * (i%4) + 120, self.contentSize.height - 180 * ((i-12*(currentPageNum-1))/4) - 100);
			
			[self addChild:itemButton z:7 tag:i%12];
		
		}
			 */
	}
	
	
}  //end class

@end