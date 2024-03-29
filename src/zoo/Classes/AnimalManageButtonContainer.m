//
//  AnimalManageButtonContainer.m
//  zoo
//
//  Created by Alex Liu on 6/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalManageButtonContainer.h"
#import "DataModelAnimal.h"


//结婚时候，按钮Container，每一个按钮对应一个AnimalManagementButtonItem
@implementation AnimalManageButtonContainer

-(id) initWithTab: (NSString *)tabName setTarget:(id)target
{
	if ((self = [super init])) {
		parentTarget = target;

		tabFlag = tabName;
		if (tabFlag == @"animal") {
			NSDictionary *itemDic;
			itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].animalIDs;
			totalPage = ([[DataEnvironment sharedDataEnvironment].animalIDs count]-1)/8 + 1;
			currentPageNum = 1;
			[self generatePage];
			
			Button *nextPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_右.png" setTarget:self setSelector:@selector(nextPage:) setPriority:40 offsetX:0 offsetY:0 scale:3.0f];
			Button *forwardPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_左.png" setTarget:self setSelector:@selector(forwardPage:) setPriority:40 offsetX:0 offsetY:0 scale:3.0f];
			//		forwardPageBtn.flipX = YES;
			nextPageBtn.position = ccp(700, -450);
			forwardPageBtn.position = ccp(200, -450);
			[self addChild:nextPageBtn z:7];
			[self addChild:forwardPageBtn z:7];
			self.scale = 300.0f/1024.0f;
			[nextPageBtn release];
			[forwardPageBtn release];
		}
	
		NSString* title = [NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage];
		pageLabel = [CCLabel labelWithString:title fontName:@"Arial" fontSize:50];
		[pageLabel setColor:ccc3(0, 0, 0)];
		pageLabel.position = ccp(450,-450);
		[self addChild:pageLabel z:7];
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
	if(itemArray.count == 0)
	{
		totalPage = 1;
	}
	else 
	{
		totalPage = (itemArray.count-1)/8 + 1;
	}
	
	currentPageNum = 1;
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
		for (int i = 0; i< currentNum*2; i ++) 
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
	if (currentPageNum - 1 > 0) 
	{
		for (int i = 0; i< currentNum*2; i ++) 
		{
			[self removeChildByTag:i cleanup:YES];
		}
		
		currentPageNum = currentPageNum - 1;
		[self generatePage];
		
		[pageLabel setString:[NSString stringWithFormat:@"%d/%d",currentPageNum,totalPage]];
	}
}

-(void) generatePage
{
	if (tabFlag == @"animal") {
		NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
		DataModelOriginalAnimal *originAnimal;
		NSString *aniID;
		int endNumber = currentPageNum * 8;
		if (endNumber >= [[DataEnvironment sharedDataEnvironment].animalIDs count]) {
			endNumber = [[DataEnvironment sharedDataEnvironment].animalIDs count];
		}
		currentNum = endNumber - (currentPageNum -1 ) *8;
		AnimalManagementButtonItem *itemButton;
		DataModelAnimal *serverAnimalData2;
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
			originAnimal = [animalIDs objectAtIndex:i];
			aniID = [animalIDs objectAtIndex:i];
			serverAnimalData2 = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
			NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalData2.scientificNameCN];
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalData2.picturePrefix];
			NSString *orgid = [NSString stringWithFormat:@"%d",serverAnimalData2.originalAnimalId];
			
			itemButton = [[AnimalManagementButtonItem alloc] initWithItem:orgid setitType:tabFlag setAnimalID:aniID setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:40 offsetX:1 offsetY:1 setPictureScale:2.5f];
			itemButton.position = ccp(230 * (i%4) + 110, self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 110);
			[self addChild:itemButton z:7 tag:i%8];
		}
	}
}



-(void)dealloc
{
	//[tabFlag release];
	//[parentTarget release];
	[super dealloc];
}

@end
