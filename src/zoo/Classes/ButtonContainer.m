//
//  ButtonContainer.m
//  zoo
//
//  Created by Rainbow on 5/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ButtonContainer.h"

@implementation ButtonContainer


//根据Tab加载商品内容
-(id) initWithTab: (NSString *)tabName setTarget:(id)target
{
	if ((self = [super init])) {
		parentTarget = target;
//		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_2.png" ofType:nil] ] ];
//		CGRect rect = CGRectZero;
//		bg.scale = 1024.0/300.0f;
//		rect.size = CGSizeMake(900,400);
//		[self setTexture: bg];
//		[self setTextureRect: rect];
//		[bg release];
		tabFlag = tabName;
		if (tabFlag == @"动物") {
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		else if(tabFlag == @"饲料"){
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllFoods WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		else if(tabFlag == @"道具"){
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllGoods WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		self.scale = 300.0f/1024.0f;
		
		
		
		//实现翻页按钮
		Button *nextPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_右.png" setTarget:self setSelector:@selector(nextPage:) setPriority:40 offsetX:0 offsetY:0 scale:3.0f];
		Button *forwardPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_左.png" setTarget:self setSelector:@selector(forwardPage:) setPriority:40 offsetX:0 offsetY:0 scale:3.0f];
//		forwardPageBtn.flipX = YES;
		nextPageBtn.position = ccp( 770, -480);
		forwardPageBtn.position = ccp(200, -480);
		[self addChild:nextPageBtn z:7];
		[self addChild:forwardPageBtn z:7];
		
		[nextPageBtn release];
		[forwardPageBtn release];
		
		
	}
	return self;
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *itemDic;
	NSArray *itemArray;
	if (tabFlag == @"动物") {
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
		itemArray = [itemDic allKeys];
	}
	else if(tabFlag == @"饲料")
	{
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].foods;
		itemArray = [itemDic allKeys];
	}
	else if(tabFlag == @"道具")
	{
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].goods;
		itemArray = [itemDic allKeys];
	}
	if(itemArray.count == 0)
	{
		totalPage = 1;
	}
	else 
	{
		totalPage = (itemArray.count-1)/8 + 1;
	}
	
	currentPageNum = 1;
	
	NSString* title = [NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage];
	pageLabel = [CCLabel labelWithString:title fontName:@"Arial" fontSize:50];
	[pageLabel setColor:ccc3(0, 0, 0)];
	pageLabel.position = ccp(500,-480);
	[self addChild:pageLabel z:7];
	
	[self generatePage];
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

-(void) nextPage:(Button *)button
{
	if ( currentPageNum + 1 <= totalPage) 
	{
		for (int i = 0; i< currentNum * 2; i ++) 
		{
			[self removeChildByTag:i cleanup:YES];
		}
		
		currentPageNum = currentPageNum + 1;
		[self generatePage];
		
		[pageLabel setString:[NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage]];
	}
}

-(void) forwardPage:(Button *)button
{
	if (currentPageNum - 1 > 0) {
		for (int i = 0; i< currentNum * 2; i ++) {
			[self removeChildByTag:i cleanup:YES];
		}
		
		currentPageNum = currentPageNum - 1;
		[self generatePage];
		
		[pageLabel setString:[NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage]];
	}
}

//生成商品页面
-(void) generatePage
{
	if (tabFlag == @"动物") 
	{
		NSDictionary *originAnimalDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
		
		DataModelOriginalAnimal *originAnimal; //levelRequired
		NSArray *animalArrayTemp1 = [originAnimalDic allKeys];
		NSMutableArray* animalArrayTemp = [[NSMutableArray alloc] init];
		[animalArrayTemp addObjectsFromArray:animalArrayTemp1];
		
		NSMutableArray* arrOfLevel = [[NSMutableArray alloc]init];
		
		for(int i = 0; i < [animalArrayTemp count]; i++)
		{
			originAnimal = [originAnimalDic objectForKey:[animalArrayTemp objectAtIndex:i]];
			
			[arrOfLevel addObject:[NSNumber numberWithInt:originAnimal.levelRequired]];
		}
		
		// 冒泡排序
		int nTemp;
		NSString* strTemp;
		for(int j = 0; j <= [arrOfLevel count] - 1 ; j++)
		{
			for(int i = 0; i < [arrOfLevel count] - 1- j; i++)
			{
				if([[arrOfLevel objectAtIndex:i] intValue] >= [[arrOfLevel objectAtIndex:i+1] intValue])
				{
					nTemp = [[arrOfLevel objectAtIndex:i] intValue];
					strTemp = [animalArrayTemp objectAtIndex:i];
					
					int nRight = [[arrOfLevel objectAtIndex:i+1] intValue];
					NSString* strRight = [animalArrayTemp objectAtIndex:i + 1];
					
					[arrOfLevel replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:nRight]];
					[animalArrayTemp replaceObjectAtIndex:i withObject:strRight];
					
					[arrOfLevel replaceObjectAtIndex:i+1 withObject:[NSNumber numberWithInt:nTemp]];
					[animalArrayTemp replaceObjectAtIndex:i + 1 withObject:strTemp];
					
				}
			}
		}
		
		
		//		for(int i = 0; i < [animalArrayTemp count]; i++)
		//			NSLog(@"%@\n", [animalArrayTemp objectAtIndex:i]);
		
		
		
		
		NSArray* animalArray = [NSArray arrayWithArray:animalArrayTemp];
		
		int endNumber = currentPageNum * 8;
		if (endNumber >= animalArray.count) 
		{
			endNumber = animalArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *8 ;
		
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) 
		{
			originAnimal = [originAnimalDic objectForKey:[animalArray objectAtIndex:i]];
			
			int buyType = 0;
			NSString *price = [NSString stringWithFormat:@"%d",originAnimal.basePrice];
			if (originAnimal.antsPrice > 0) {
				buyType = 1;
				price = [NSString stringWithFormat:@"%d",originAnimal.antsPrice];
			}
//			if (originAnimal.originalAnimalId > 0) 
			
			//根据动物的originalAnimalId生成ItemButton
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",originAnimal.picturePrefix];
			ItemButton *itemButton = [[ItemButton alloc] initWithItem:originAnimal.originalAnimalId setitType:tabFlag setImagePath:picFileName setBuyType:buyType setPrice:price setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:40 offsetX:1 offsetY:1];
			
		 	NSLog(@"%@\n",itemButton.itemId); 
			
			itemButton.position = ccp(250 * (i%4) + 110,  self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 100);
			[self addChild:itemButton z:7 tag:i%8];
			[itemButton release];
		}
	}
	else if (tabFlag == @"饲料"){
		NSDictionary *foodDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].foods;
		DataModelFood *dataModelFood;
		NSArray *foodArray = [foodDic allKeys];
		int endNumber = currentPageNum * 8;
		if (endNumber >= foodArray.count) {
			endNumber = foodArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *8 ;
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
			dataModelFood = [foodDic objectForKey:[foodArray objectAtIndex:i]];
			
			int buyType = 0;
			NSString *price = [NSString stringWithFormat:@"%d",dataModelFood.foodPrice];
			if (dataModelFood.antsRequired > 0) {
				buyType = 1;
				price = [NSString stringWithFormat:@"%d",dataModelFood.antsRequired];
			}
			NSString *picFileName = [NSString stringWithFormat:@"food_%@.png",dataModelFood.foodImg];
			ItemButton *itemButton = [[ItemButton alloc] initWithItem:dataModelFood.foodId setitType:tabFlag setImagePath:picFileName setBuyType:buyType setPrice:price setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:40 offsetX:1 offsetY:1];
			itemButton.position = ccp(250 * (i%4) + 110, self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 100);
			[self addChild:itemButton z:7 tag:i%8];
			[itemButton release];
		}
	}
	else if (tabFlag == @"道具"){
		NSDictionary *goodsDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].goods;
		DataModelGood *dataModelGood;
		NSArray *goodsArray = [goodsDic allKeys];
		int endNumber = currentPageNum * 8;
		if (endNumber >= goodsArray.count) {
			endNumber = goodsArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *8 ;
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
			dataModelGood = [goodsDic objectForKey:[goodsArray objectAtIndex:i]];
			int buyType = 0;
			NSString *price = [NSString stringWithFormat:@"%d",dataModelGood.goodsGoldenPrice];
			if (dataModelGood.goodsAntsPrice > 0) {
				buyType = 1;
				price = [NSString stringWithFormat:@"%d",dataModelGood.goodsAntsPrice];
			}
			NSString *picFileName;
			if ([dataModelGood.goodsPicture intValue]== 1) {
				picFileName = @"tibentanmastiff_rest_01.png";
			}
			else if([dataModelGood.goodsPicture intValue]== 2)
			{	
				picFileName = @"chinemy_walk_left_01.png";
			}
			ItemButton *itemButton = [[ItemButton alloc] initWithItem:dataModelGood.goodsId setitType:tabFlag setImagePath:picFileName setBuyType:buyType setPrice:price setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:40 offsetX:1 offsetY:1];
			itemButton.position = ccp(250 * (i%4) + 110, self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 100);
			[self addChild:itemButton z:7 tag:i%8];
			[itemButton release];
//			CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
//			kuang.position = ccp(250 * (i%4) + 110,  self.contentSize.height - 215 * ((i-8*(currentPageNum-1))/4) - 100);
//			kuang.scale = 1024.0/400.0f;
//			[self addChild:kuang z:6 tag:i%8 + 8];
		}
	}

}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
//	[tabFlag release];
//	[parentTarget release];
	
	[super dealloc];
}




@end
