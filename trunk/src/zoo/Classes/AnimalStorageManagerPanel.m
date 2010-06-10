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
		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ButtonContainer.png" ofType:nil] ] ];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[self setTexture: bg];
		[self setTextureRect: rect];
		[bg release];
		tabFlag = tabName;
		currentPageNum = 1;
		
		if (tabFlag == @"stoAnimals") {

			//TODO: modify the current Page Number;
		}
		
		
		NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId;
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",nil];
		if (tabFlag == @"stoAnimals") {
			
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
		}
		else if(tabFlag == @"auctionAnimals"){
			[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageAuctionAnimal WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
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
	if (tabFlag == @"stoAnimals") {
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAnimals;
		itemArray = [itemDic allKeys];
	}
	else if(tabFlag == @"auctionAnimals")
	{
		itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAuctionAnimals;
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
	if (tabFlag == @"stoAnimals") {
		NSDictionary *storageAnimal = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAnimals;
		DataModelStorageAnimal *stoAnimals;
		NSArray *animalArray = [storageAnimal allKeys];
		
		int endNumber = currentPageNum * 12;
		if (endNumber >= animalArray.count) {
			endNumber = animalArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *12 ;
		for (int i = (currentPageNum -1)*12; i < endNumber; i ++) {
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
			AnimalStorageManagerButtonItem *itemButton = [[AnimalStorageManagerButtonItem alloc] initWithItems:stoAnimals.adultBirdStorageId setitType:tabFlag setAmount:stoAnimals.amount setGender:gender setAnimalID:stoAnimals.originalAnimalId setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
			itemButton.position = ccp(225 * (i%4) + 120, self.contentSize.height - 180 * ((i-12*(currentPageNum-1))/4) - 100);
			[self addChild:itemButton z:7 tag:i%12];
		}
	}
	if (tabFlag == @"auctionAnimals") {
		NSDictionary *auctionAnimals = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageAuctionAnimals;
		DataModelStorageAuctionAnimal *stoauAnimals;
		NSArray *animalArray = [auctionAnimals allKeys];
		
		int endNumber = currentPageNum * 12;
		if (endNumber >= animalArray.count) {
			endNumber = animalArray.count;
		}
		currentNum = endNumber - (currentPageNum -1 ) *12 ;
		for (int i = (currentPageNum -1)*12; i < endNumber; i ++) {
			stoauAnimals = [auctionAnimals objectForKey:[animalArray objectAtIndex:i]];
			DataModelAnimal *serverAnimalShow = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].storageAuctionAnimals objectForKey:stoauAnimals.auctionBirdStorageId];
			NSInteger n = 0;
			NSString *localGender;
			if (serverAnimalShow.gender == 0) {
				localGender = @"母";
			}
			else {
				localGender = @"公";
			}

			NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalShow.scientificNameCN];
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalShow.picturePrefix];
			AnimalStorageManagerButtonItem *itemButton = [[AnimalStorageManagerButtonItem alloc] initWithItems:stoauAnimals.auctionBirdStorageId setitType:tabFlag setAmount:n setGender:localGender setAnimalID:serverAnimalShow.animalId setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
			//AnimalStorageManagerButtonItem *itemButton = [[AnimalStorageManagerButtonItem alloc] initWithItems:stoauAnimals.auctionBirdStorageId setitType:tabFlag setAmount:n setGender:serverAnimalShow.gender setAnimalID:serverAnimalShow.animalId setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1];
			itemButton.position = ccp(225 * (i%4) + 120, self.contentSize.height - 180 * ((i-12*(currentPageNum-1))/4) - 100);
			[self addChild:itemButton z:7 tag:i%12];
		}
		
	}
}

@end
