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
	 tabFlag = tabName;
	 itemNumArray = [ [NSMutableArray alloc] init];
	 
//	 CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ButtonContainer.png" ofType:nil] ] ];
//	 CGRect rect = CGRectZero;
//	 rect.size = bg.contentSize;
//	 [self setTexture: bg];
//	 [self setTextureRect: rect];
//	 [bg release];
	 
	 eggEnNameArray = [[NSArray alloc] initWithObjects:@"craneEgg.png",@"duckEgg.png",@"gooseEgg.png",@"henEgg.png",@"magpieEgg.png",@"mallardEgg.png",@"mandarinduckEgg.png",@"parrotEgg.png",@"peahenEgg.png",@"pheasantEgg.png",@"pigeonEgg.png",@"swanEgg.png",@"turkeyEgg.png",@"wildgooseEgg.png",@"mallardEgg.png",@"pigeonEgg.png",nil];
	 self.scale = 300.0f/1024.0f;
	 [self initView];
	 
 }
 return self;
 }
 
 
-(void) initView
{
	
	 [self removeAllChildrenWithCleanup:YES];
	
	
	
	NSString *par = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:par,@"farmerId",nil];
	if (tabFlag == @"egg") {
		
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageProducts WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	}
	else if(tabFlag == @"zygoteegg"){
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageZygoteEgg WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultZygCallback:" AndFailedSel:@"faultCallback:"];
	}
	
		
}
	
	


-(void) resultCallback:(NSObject *)value
{
	
	
	NSDictionary *itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageEggs;
	NSArray *itemArray = [itemDic allKeys];

	totalPage = itemArray.count/8 + 1;
	
	currentPageNum = 1;
	[self generatePage];
	
	NSString *totalStrPrice = [NSString stringWithFormat:@"当前总计收入 ：%d  金蛋",totalPrice];
	totalPriceLab = [CCLabel labelWithString:totalStrPrice fontName:@"Arial" fontSize:40];
	
	totalPriceLab.position = ccp(self.contentSize.width/2 - 100, 20);
	[totalPriceLab setColor:ccc3(0, 0, 0)];
	[self addChild:totalPriceLab z:7 tag:10];
	
}


-(void) resultZygCallback:(NSObject *)value
{
	
	NSDictionary *itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageZygoteEggs;
	NSArray *itemArray = [itemDic allKeys];
	
	totalPage = itemArray.count/8 + 1;
	currentPageNum = 1;
	[self generatePage];
	
	NSString *totalStrPrice = [NSString stringWithFormat:@"当前总计收入 ：%d  金蛋",totalPrice];
	[totalPriceLab	setString:totalStrPrice];
	
}


-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}



-(void) addChangePageButton
{
	
	Button *nextPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(nextPage:) setPriority:1 offsetX:0 offsetY:0 scale:1.0f];
	Button *forwardPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(forwardPage:) setPriority:1 offsetX:0 offsetY:0 scale:1.0f];
	
	forwardPageBtn.flipX = YES;
	nextPageBtn.position = ccp(self.contentSize.width/2 + 100, 0);
	forwardPageBtn.position = ccp(self.contentSize.width/2 - 100, 0);
	
	[self addChild:nextPageBtn z:7];
	[self addChild:forwardPageBtn z:7];
	
	
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

		DataModelStorageEgg *storageEgg;
		
		NSArray *eggsArray = [storageEggDic allKeys];
		
		int endNumber = currentPageNum * 8;
		
		if (endNumber >= eggsArray.count) {
			endNumber = eggsArray.count;
			
		}
		
		currentNum = endNumber - (currentPageNum -1 ) *8 ;
		
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
			
			storageEgg = [storageEggDic objectForKey:[eggsArray objectAtIndex:i]];
			
			[eggSourceArray addObject:storageEgg];
			
			
			
			int eggImgId = [storageEgg.eggImgId intValue];
			
			
			NSString *picName = [NSString stringWithFormat:@"%@", [eggEnNameArray objectAtIndex:eggImgId] ];
			NSString *eggName = [NSString stringWithFormat:@"%@",storageEgg.eggNameEN];
			NSString *eggTotal = [NSString stringWithFormat:@"%d",(storageEgg.numOfProduct + storageEgg.numOfStolen)];
			NSArray *eNameArr = [picName componentsSeparatedByString:@" "];
			
			totalPrice += (storageEgg.numOfProduct + storageEgg.numOfStolen) * storageEgg.eggPrice;
							
			SellitemButton *itemButton = [[SellitemButton alloc] initWithItem:storageEgg.eggStorageId setitType:tabFlag setImagePath:picName setEggTotal:eggTotal setEggName:storageEgg.eggName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
	
			itemButton.position = ccp(250 * (i%4) + 110, self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 100);
			
			[itemNumArray addObject:itemButton];
			
			CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
			kuang.position = ccp(250 * (i%4) + 110,  self.contentSize.height - 215 * ((i-8*(currentPageNum-1))/4) - 100);
			kuang.scale = 1024.0/400.0f;
			[self addChild:kuang z:6];
		}
		
		
		[self addEggToStage];
		
		for (int m=0; m<eggSourceArray.count; m++) {
			[[eggSourceArray objectAtIndex:m] release];
		}

		[eggSourceArray removeAllObjects];
		[eggSourceArray release];
		
	}
			

	else if (tabFlag == @"zygoteegg"){
		NSDictionary *storageZygoteEggsDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageZygoteEggs;
		DataModelStorageZygoteEgg *dataModelStorageZygoteEggs;
		NSArray *zygoteEggsArray = [storageZygoteEggsDic allKeys];
		
		int endNumber = currentPageNum * 8;
		if (endNumber >= zygoteEggsArray.count) {
			endNumber = zygoteEggsArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *8 ;
		
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
			dataModelStorageZygoteEggs = [storageZygoteEggsDic objectForKey:[zygoteEggsArray objectAtIndex:i]];

			NSString *picName = [NSString stringWithFormat:@"%@",dataModelStorageZygoteEggs.eggId];
			NSString *eggZnName = [NSString stringWithFormat:@"%@",dataModelStorageZygoteEggs.eggName];

			NSString *eggTotal = [NSString stringWithFormat:@""];

			totalPrice += dataModelStorageZygoteEggs.eggPrice;
			
			
			NSString *picFileName = [NSString stringWithFormat:@"zygote%@.png",picName];
						
			SellitemButton *itemButton = [[SellitemButton alloc] initWithItem:dataModelStorageZygoteEggs.zygoteStorageId setitType:tabFlag setImagePath:picFileName setEggTotal:eggTotal setEggName:eggZnName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
	
			[itemNumArray addObject:itemButton];
			
			itemButton.position = ccp(250 * (i%4) + 110, self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 100);
	
	
			CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
			kuang.position = ccp(250 * (i%4) + 110,  self.contentSize.height - 215 * ((i-8*(currentPageNum-1))/4) - 100);
			kuang.scale = 1024.0/400.0f;
			[self addChild:kuang z:6];
	}
		[self addEggToStage];
				
		zygoteEggsArray = nil;
		[zygoteEggsArray release];
			 
	}
	

	
	
}  //end class



-(void) addEggToStage
{
	for (int i=0; i<itemNumArray.count; i++) {
		
		[self addChild:[itemNumArray objectAtIndex:i] z:7 tag:i%12];
		
	}
	
	
}


-(void) clearToStage
{
	
	for (int i=0; i<itemNumArray.count; i++) {
		
		[self  removeChild:[itemNumArray objectAtIndex:i] cleanup:YES];
		[[itemNumArray objectAtIndex:i] release];
		
	}
	
	
}



-(void) releaseImg:(SellitemButton *)imgIco
{
	
	imgIco.scale = 0;
	[self removeChild:imgIco cleanup:YES];
	
}



-(void) upData
{
	
		for (int j=0; j<itemNumArray.count; j++) {
			
			[self releaseImg:[itemNumArray objectAtIndex:j] ];
			
		}
		
		[itemNumArray removeAllObjects];	
	
	  [self initView];
	
}


-(void) dealloc
{
	
	[self removeAllChildrenWithCleanup:YES];
	
	[tabFlag        release];
	[totalPriceLab  release];
	[totalPriceLab  release];
	[eggSourceArray release];
	[itemNumArray   release];
	[parentTarget   release];
	[super dealloc];
	 
}








@end