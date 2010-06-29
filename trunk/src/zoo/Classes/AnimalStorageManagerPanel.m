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

@implementation AnimalStorageManagerPanel

-(id) initWithTab: (NSString *)tabName setTarget:(id)target
{
	if ((self = [super init])) {
		parentTarget = target;
//		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_1.png" ofType:nil] ] ];
//		CGRect rect = CGRectZero;
//		rect.size = bg.contentSize;
//		[self setTexture: bg];
//		[self setTextureRect: rect];
//		[bg release];
		tabFlag = tabName;
		currentPageNum = 1;
		
		if (tabFlag == @"stoAnimals") {

			//TODO: modify the current Page Number;
		}
		self.scale = 300.0f/1024.0f;
		
		NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",nil];
		if (tabFlag == @"stoAnimals") {
			
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		else if(tabFlag == @"auctionAnimals"){
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAuctionAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		
		
	}
	return self;
}


-(void) resultCallback:(NSObject *)value
{
	NSDictionary *itemDic;
	NSArray *itemArray;
	if (tabFlag == @"stoAnimals") {
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAnimals;
		itemArray = [itemDic allKeys];
	}
	else if(tabFlag == @"auctionAnimals")
	{
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAuctionAnimals;
		itemArray = [itemDic allKeys];
	}
	totalPage = itemArray.count/8 + 1;
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
	if (tabFlag == @"stoAnimals") {
		NSDictionary *storageAnimal = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAnimals;
		DataModelStorageAnimal *stoAnimals;
		NSArray *animalArray = [storageAnimal allKeys];
		
		int endNumber = currentPageNum * 8;
		if (endNumber >= animalArray.count) {
			endNumber = animalArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *8 ;
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
			stoAnimals = [storageAnimal objectForKey:[animalArray objectAtIndex:i]];
			DataModelOriginalAnimal *serverAnimalToshow = (DataModelOriginalAnimal *)[[DataEnvironment sharedDataEnvironment].originalAnimals objectForKey:stoAnimals.originalAnimalId];			
			NSString *gender;
			if ([serverAnimalToshow.originalAnimalId intValue] > 50) {
				gender = @"母";
			}
			else {
				gender = @"公";
			}

			NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalToshow.scientificNameCN];
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalToshow.picturePrefix];
			AnimalStorageManagerButtonItem *itemButton = [[AnimalStorageManagerButtonItem alloc] initWithItems:stoAnimals.adultBirdStorageId setitType:tabFlag setAmount:stoAnimals.amount setGender:gender setAnimalID:stoAnimals.originalAnimalId setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:40 offsetX:1 offsetY:1];
			itemButton.position = ccp(250 * (i%4) + 120, self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 100);
			[self addChild:itemButton z:7 tag:i%8];
			
			CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
			kuang.position = ccp(250 * (i%4) + 110,  self.contentSize.height - 215 * ((i-8*(currentPageNum-1))/4) - 100);
			kuang.scale = 1024.0/400.0f;
			[self addChild:kuang z:6];
		}
	}
	if (tabFlag == @"auctionAnimals") {
		NSDictionary *auctionAnimals = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAuctionAnimals;
		DataModelStorageAuctionAnimal *stoauAnimals;
		NSArray *animalArray = [auctionAnimals allKeys];
		
		int endNumber = currentPageNum * 8;
		if (endNumber >= animalArray.count) {
			endNumber = animalArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *8 ;
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
			stoauAnimals = [auctionAnimals objectForKey:[animalArray objectAtIndex:i]];
			DataModelOriginalAnimal *serverAnimalShow = (DataModelOriginalAnimal *)[[DataEnvironment sharedDataEnvironment].originalAnimals objectForKey:stoauAnimals.originalAnimalId];			

			NSInteger n = 0;
			NSString *localGender;
			if ([serverAnimalShow.originalAnimalId intValue] > 50) {
				localGender = @"母";
			}
			else {
				localGender = @"公";
			}

			NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalShow.scientificNameCN];
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalShow.picturePrefix];
			AnimalStorageManagerButtonItem *itemButton = [[AnimalStorageManagerButtonItem alloc] initWithItems:stoauAnimals.auctionBirdStorageId setitType:tabFlag setAmount:n setGender:localGender setAnimalID:serverAnimalShow.originalAnimalId setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:40 offsetX:1 offsetY:1];
			//AnimalStorageManagerButtonItem *itemButton = [[AnimalStorageManagerButtonItem alloc] initWithItems:stoauAnimals.auctionBirdStorageId setitType:tabFlag setAmount:n setGender:serverAnimalShow.gender setAnimalID:serverAnimalShow.animalId setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
			itemButton.position = ccp(225 * (i%4) + 120, self.contentSize.height - 180 * ((i-8*(currentPageNum-1))/4) - 100);
			[self addChild:itemButton z:7 tag:i%8];
			
			CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
			kuang.position = ccp(250 * (i%4) + 110,  self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 100);
			kuang.scale = 1024.0/400.0f;
			[self addChild:kuang z:6];
		}
		
	}
}

-(void)dealloc
{
	// Add by Hunk on 2010-06-29
	[parentTarget release];
	
	[tabFlag release];
	[super dealloc];
}

@end
