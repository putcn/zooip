//
//  AnimalManagementMateOrDisList.m
//  zoo
//
//  Created by AlexLiu on 6/3/10.
//  Copyright 2010 Vance. All rights reserved.
//

#import "AnimalManagementMateOrDisList.h"
#import "DataModelAnimal.h"



@implementation AnimalManagementMateOrDisList


-(id) initWithTab: (NSString *)tabName setTarget:(id)target
{
	if ((self = [super init])) {
		parentTarget = target;
//		CCTexture2D *bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"BG_ButtonContainer.png" ofType:nil] ] ];
//		CGRect rect = CGRectZero;
//		rect.size = bg.contentSize;
//		[self setTexture: bg];
//		[self setTextureRect: rect];
//		[bg release];
		tabFlag = tabName;
		if (tabFlag == @"animal") {
			
			NSDictionary *itemDic;
			itemDic = (NSDictionary *)[DataEnvironment sharedDataEnvironment].animalIDs;
			totalPage = [[DataEnvironment sharedDataEnvironment].animalIDs count] + 1;
			currentPageNum = 1;
			[self generatePage];
		}
		
//		Button *nextPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(nextPage:) setPriority:1 offsetX:0 offsetY:0 scale:1.0f];
//		Button *forwardPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"nextpage.png" setTarget:self setSelector:@selector(forwardPage:) setPriority:1 offsetX:0 offsetY:0 scale:1.0f];
//		forwardPageBtn.flipX = YES;
//		nextPageBtn.position = ccp(self.contentSize.width/2 + 100, 0);
//		forwardPageBtn.position = ccp(self.contentSize.width/2 - 100, 0);
//		[self addChild:nextPageBtn z:7];
//		[self addChild:forwardPageBtn z:7];
		
		Button *nextPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_右.png" setTarget:self setSelector:@selector(nextPage:) setPriority:1 offsetX:0 offsetY:0 scale:3.0f];
		Button *forwardPageBtn = [[Button alloc] initWithLabel:@"" setColor:ccc3(255, 255, 255) setFont:@"Arial" setSize:12 setBackground:@"加减器_左.png" setTarget:self setSelector:@selector(forwardPage:) setPriority:1 offsetX:0 offsetY:0 scale:3.0f];
		//		forwardPageBtn.flipX = YES;
		nextPageBtn.position = ccp(700, -450);
		forwardPageBtn.position = ccp(200, -450);
		[self addChild:nextPageBtn z:7];
		[self addChild:forwardPageBtn z:7];
		self.scale = 300.0f/1024.0f;
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
	if (tabFlag == @"animal") {
		NSMutableArray *animalIDs = (NSMutableArray *)[DataEnvironment sharedDataEnvironment].animalIDs;
		DataModelOriginalAnimal *originAnimal;
		NSString *aniID;
		int endNumber = currentPageNum * 8;
		if (endNumber >= [[DataEnvironment sharedDataEnvironment].animalIDs count]) {
			endNumber = [[DataEnvironment sharedDataEnvironment].animalIDs count];
		}
		currentNum = endNumber - (currentPageNum -1 ) *8 ;
		for (int i = (currentPageNum -1)*8; i < endNumber; i ++) {
			originAnimal = [animalIDs objectAtIndex:i];
			aniID = [animalIDs objectAtIndex:i];
			DataModelAnimal *serverAnimalData2 = (DataModelAnimal *)[[DataEnvironment sharedDataEnvironment].animals objectForKey:aniID];
			if(serverAnimalData2.coupleAnimalId != nil)
			{
			NSString *animalName = [NSString stringWithFormat:@"%d",serverAnimalData2.scientificNameCN];
			NSString *picFileName = [NSString stringWithFormat:@"%@.png",serverAnimalData2.picturePrefix];
			NSString *orgid = [NSString stringWithFormat:@"%d",serverAnimalData2.originalAnimalId];
			AnimalManagementButtonItem *itemButton = [[AnimalManagementButtonItem alloc] initWithItem:orgid setitType:tabFlag setAnimalID:aniID setImagePath:picFileName setAnimalName:animalName setTarget:parentTarget setSelector:@selector(itemInfoHandler:) setPriority:2 offsetX:1 offsetY:1 setPictureScale:2.0];
			itemButton.position = ccp(230 * (i%4) + 120, self.contentSize.height - 220 * ((i-8*(currentPageNum-1))/4) - 140);
			[self addChild:itemButton z:7 tag:i%8];
			}
			
			CCSprite* kuang = [CCSprite spriteWithFile:@"物品边框.png"];
			kuang.position = ccp(230 * (i%4) + 110,  self.contentSize.height - 215 * ((i-8*(currentPageNum-1))/4) - 100);
			kuang.scale = 1024.0/400.0f;
			[self addChild:kuang z:6];
		}
	}
	
}


-(void)dealloc
{
	[tabFlag release];
	[parentTarget release];
	[super dealloc];
}

@end
