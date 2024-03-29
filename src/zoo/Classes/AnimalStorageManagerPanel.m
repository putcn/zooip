//
//  AnimalStorageManagerPanel.m
//  zoo
//
//  Created by Alex Liu on 10-6-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalStorageManagerPanel.h"
#import "DataModelStorageAnimal.h"
#import "DataModelStorageAuctionAnimal.h"
#import "ServiceHelper.h"
#import "DataModelAnimal.h"


//仓库里面的动物面板
@implementation AnimalStorageManagerPanel

-(id) initWithTab: (NSString *)tabName setTarget:(id)target setNumber:(int)_nNumber
{
	if ((self = [super init])) {
		parentTarget = target;
		tabFlag = tabName;
		currentPageNum = 1;
		
		if (tabFlag == @"动物") {

			//TODO: modify the current Page Number;
		}
		self.scale = 300.0f/1024.0f;
		
		m_nNumber = _nNumber;
		if( m_nNumber== 1)
		{
			[self removeAllChildrenWithCleanup:YES];
//			[self clearPage: tabFlag setTarget:self];
		}

		{
			NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
			NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",nil];
			if (tabFlag == @"动物") {
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			}
			else if(tabFlag == @"拍来动物"){
				[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAuctionAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
			}
		}
		
		
		
		
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
//	[self clearPage: tabFlag setTarget:self];
	
	//NSLog(@"%@",value);
	NSDictionary *itemDic;
	NSArray *itemArray;
	if (tabFlag == @"动物") {
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAnimals;
		itemArray = [itemDic allKeys];
	}
	else if(tabFlag == @"拍来动物")
	{
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAuctionAnimals;
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
	if( m_nNumber!= 1)
	[self generatePage];
	
	NSString* title = [NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage];
	pageLabel = [CCLabel labelWithString:title fontName:@"Arial" fontSize:50];
	[pageLabel setColor:ccc3(0, 0, 0)];
	pageLabel.position = ccp(500,-480);
	[self addChild:pageLabel z:7];
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
		
		[pageLabel setString:[NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage]];
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
		
		[pageLabel setString:[NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage]];
	}
}

-(void) clearPage: (NSString *)tabName setTarget:(id)target
{
	for (int i = 0; i< currentNum; i ++) {
		[self removeChildByTag:i cleanup:YES];
	}
}


-(void) generatePage
{	
	NSLog(@"************* generatePage ***********************");
	if (tabFlag == @"动物") {
		NSDictionary *storageAnimal = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAnimals;
		DataModelStorageAnimal *stoAnimals;
		NSArray *animalArray = [storageAnimal allKeys];
		
		int endNumber = currentPageNum * 8;
		if (endNumber >= animalArray.count) {
			endNumber = animalArray.count;
		}
		CCSprite *gender;
		AnimalStorageManagerButtonItem *itemButton;
		currentNum = endNumber - (currentPageNum -1 ) *8 ;
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
			stoAnimals = [storageAnimal objectForKey:[animalArray objectAtIndex:i]];
			DataModelOriginalAnimal *serverAnimalToshow = (DataModelOriginalAnimal *)[[DataEnvironment sharedDataEnvironment].originalAnimals objectForKey:stoAnimals.originalAnimalId];			
			
			if ([serverAnimalToshow.originalAnimalId intValue] > 50) {
				gender = [CCSprite spriteWithFile:@"公.png"];
			}
			else {
				gender = [CCSprite spriteWithFile:@"母.png"];
			}

			NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalToshow.scientificNameCN];
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalToshow.picturePrefix];
			itemButton = [[AnimalStorageManagerButtonItem alloc] initWithItems:stoAnimals.adultBirdStorageId setitType:tabFlag setAmount:stoAnimals.amount setGender:gender setAnimalID:stoAnimals.originalAnimalId setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:0 offsetX:1 offsetY:1];
			itemButton.position = ccp(250 * (i%4) + 110, self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 80);
			[self addChild:itemButton z:7 tag:i%8];
		}

	}
	if (tabFlag == @"拍来动物") {
		NSDictionary *auctionAnimals = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAuctionAnimals;
		DataModelStorageAuctionAnimal *stoauAnimals;
		NSArray *animalArray = [auctionAnimals allKeys];
		
		int endNumber = currentPageNum * 8;
		if (endNumber >= animalArray.count) {
			endNumber = animalArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *8 ;
		DataModelOriginalAnimal *serverAnimalShow;
		CCSprite *localGender;
		AnimalStorageManagerButtonItem *itemButton;
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
			stoauAnimals = [auctionAnimals objectForKey:[animalArray objectAtIndex:i]];
			serverAnimalShow = (DataModelOriginalAnimal *)[[DataEnvironment sharedDataEnvironment].originalAnimals objectForKey:stoauAnimals.originalAnimalId];			

			NSInteger n = 0;

			if ([serverAnimalShow.originalAnimalId intValue] > 50) {
				localGender = [CCSprite spriteWithFile:@"公.png"];
			}
			else {
				localGender = [CCSprite spriteWithFile:@"母.png"];
			}

			NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalShow.scientificNameCN];
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalShow.picturePrefix];
			itemButton = [[AnimalStorageManagerButtonItem alloc] initWithItems:stoauAnimals.auctionBirdStorageId setitType:tabFlag setAmount:n setGender:localGender setAnimalID:serverAnimalShow.originalAnimalId setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:0 offsetX:1 offsetY:1];
			//AnimalStorageManagerButtonItem *itemButton = [[AnimalStorageManagerButtonItem alloc] initWithItems:stoauAnimals.auctionBirdStorageId setitType:tabFlag setAmount:n setGender:serverAnimalShow.gender setAnimalID:serverAnimalShow.animalId setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
			itemButton.position = ccp(250 * (i%4) + 110, self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 80);
			[self addChild:itemButton z:7 tag:i%8];
			
		}

	}
}

-(void)updatePage
{
	for (int i = 0; i< currentNum; i ++) {
		[self removeChildByTag:i cleanup:YES];
	}
	NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",nil];
	if (tabFlag == @"动物") {
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	}
	else if(tabFlag == @"拍来动物"){
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAuctionAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	}
}

-(void)dealloc
{
	// Add by Hunk on 2010-06-29
//	[parentTarget release];
	
//	[tabFlag release];
	[super dealloc];
}

@end
