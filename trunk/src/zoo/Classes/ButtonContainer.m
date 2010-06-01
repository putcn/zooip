//
//  ButtonContainer.m
//  zoo
//
//  Created by Rainbow on 5/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ButtonContainer.h"

@implementation ButtonContainer

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
		if (tabFlag == @"animal") {
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		else if(tabFlag == @"food"){
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllFoods WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		else if(tabFlag == @"goods"){
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllGoods WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}

		Button *nextPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(nextPage:) setPriority:1 offsetX:0 offsetY:0 scale:1.0f];
		Button *forwardPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(forwardPage:) setPriority:1 offsetX:0 offsetY:0 scale:1.0f];
		forwardPageBtn.flipX = YES;
		nextPageBtn.position = ccp(self.contentSize.width/2 + 100, 0);
		forwardPageBtn.position = ccp(self.contentSize.width/2 - 100, 0);
		[self addChild:nextPageBtn z:7];
		[self addChild:forwardPageBtn z:7];
	}
	return self;
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *itemDic;
	NSArray *itemArray;
	if (tabFlag == @"animal") {
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
		itemArray = [itemDic allKeys];
	}
	else if(tabFlag == @"food")
	{
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].foods;
		itemArray = [itemDic allKeys];
	}
	else if(tabFlag == @"goods")
	{
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].goods;
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
	if (tabFlag == @"animal") {
		NSDictionary *originAnimalDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].originalAnimals;
		DataModelOriginalAnimal *originAnimal;
		NSArray *animalArray = [originAnimalDic allKeys];
		int endNumber = currentPageNum * 12;
		if (endNumber >= animalArray.count) {
			endNumber = animalArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *12 ;
		for (int i = (currentPageNum -1)*12; i < endNumber; i ++) {
			originAnimal = [originAnimalDic objectForKey:[animalArray objectAtIndex:i]];
			
			int buyType = 0;
			NSString *price = [NSString stringWithFormat:@"%d",originAnimal.basePrice];
			if (originAnimal.antsPrice > 0) {
				buyType = 1;
				price = [NSString stringWithFormat:@"%d",originAnimal.antsPrice];
			}
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",originAnimal.picturePrefix];
			ItemButton *itemButton = [[ItemButton alloc] initWithItem:originAnimal.originalAnimalId setitType:tabFlag setImagePath:picFileName setBuyType:buyType setPrice:price setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
			itemButton.position = ccp(225 * (i%4) + 120, self.contentSize.height - 180 * ((i-12*(currentPageNum-1))/4) - 100);
			[self addChild:itemButton z:7 tag:i%12];
		}
	}
	else if (tabFlag == @"food"){
		NSDictionary *foodDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].foods;
		DataModelFood *dataModelFood;
		NSArray *foodArray = [foodDic allKeys];
		int endNumber = currentPageNum * 12;
		if (endNumber >= foodArray.count) {
			endNumber = foodArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *12 ;
		for (int i = (currentPageNum -1)*12; i < endNumber; i ++) {
			dataModelFood = [foodDic objectForKey:[foodArray objectAtIndex:i]];
			
			int buyType = 0;
			NSString *price = [NSString stringWithFormat:@"%d",dataModelFood.foodPrice];
			if (dataModelFood.antsRequired > 0) {
				buyType = 1;
				price = [NSString stringWithFormat:@"%d",dataModelFood.antsRequired];
			}
			NSString *picFileName = [NSString stringWithFormat:@"food_%@.png",dataModelFood.foodImg];
			ItemButton *itemButton = [[ItemButton alloc] initWithItem:dataModelFood.foodId setitType:tabFlag setImagePath:picFileName setBuyType:buyType setPrice:price setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
			itemButton.position = ccp(225 * (i%4) + 120, self.contentSize.height - 180 * ((i-12*(currentPageNum-1))/4) - 100);
			[self addChild:itemButton z:7 tag:i%12];
		}
	}
	else if (tabFlag == @"goods"){
		NSDictionary *goodsDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].goods;
		DataModelGood *dataModelGood;
		NSArray *goodsArray = [goodsDic allKeys];
		int endNumber = currentPageNum * 12;
		if (endNumber >= goodsArray.count) {
			endNumber = goodsArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *12 ;
		for (int i = (currentPageNum -1)*12; i < endNumber; i ++) {
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
			ItemButton *itemButton = [[ItemButton alloc] initWithItem:dataModelGood.goodsId setitType:tabFlag setImagePath:picFileName setBuyType:buyType setPrice:price setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
			itemButton.position = ccp(225 * (i%4) + 120, self.contentSize.height - 180 * ((i-12*(currentPageNum-1))/4) - 100);
			[self addChild:itemButton z:7 tag:i%12];
		}
	}

}

@end
