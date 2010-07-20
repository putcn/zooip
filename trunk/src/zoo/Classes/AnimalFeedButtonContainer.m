//
//  AnimalFeedButtonContainer.m
//  zoo
//
//  Created by AlexLiu on 6/9/10.
//  Copyright 2010 Alex Dev. All rights reserved.
//

#import "AnimalFeedButtonContainer.h"
#import "DataEnvironment.h"
#import "DataModelStorageFood.h"
#import "ModelLocator.h"


//动物喂饲料。
//TODO: 弹出来的按钮需要修改。
@implementation AnimalFeedButtonContainer


-(id) initWithTarget:(id)target
{
	self = [super init];
	
	if (self)
	{
		selectIndex = 0;
		parentTarget = target;
		
		playerButtonContainer = [[CCSprite alloc] init];
		playerButtonContainer.position = ccp(20, playerButtonContainer.position.y);
		[self addChild:playerButtonContainer];
		
		NSString *farmerId = [DataEnvironment sharedDataEnvironment].playerFarmInfo.farmerId;
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:farmerId,@"farmerId",nil];
		
		[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllStorageFoods WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];

		//[self addButton];
		
		statusIcon = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"" setTarget:self
									   setSelector:@selector(btnStatusIconHandlerFeed) setPriority:0 offsetX:-1 offsetY:2 scale:0.55];
		statusIcon.position = ccp(20, 50);
		[statusIcon setVisible:YES];
		
		CCTexture2D *bg = [playerStatusIconTextures objectAtIndex:selectIndex];
		CGRect rect = CGRectZero;
		rect.size = bg.contentSize;
		[statusIcon setTexture:bg];
		[statusIcon setTextureRect: rect];
		
		[self addChild:statusIcon];
	}
	
	return self;
}

-(void)resultCallback:(NSObject *)value
{
	NSDictionary* dic = (NSDictionary*)value;
	NSArray *foodArray = [dic allKeys];
	DataModelStorageFood *dataStorageFood;
	
	for (int i = 0; i < foodArray.count; i ++) {
		dataStorageFood = [dic objectForKey:[foodArray objectAtIndex:i]];
		//NSInteger numoffood = dataStorageFood.numOfFood;
	}
	
	[self addButton];
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"%@",@"Fail call back!");
}



- (void) addButton
{
	NSDictionary *storageFood = (NSDictionary *)[DataEnvironment sharedDataEnvironment].storageFoods;
	NSArray *animalArray = [storageFood allKeys];
	DataModelStorageFood *dataStorageFood;
	
	CCTexture2D *bg;

	playerOperationButtons = [[NSMutableArray alloc] init];
	playerStatusIconTextures = [[NSMutableArray alloc] initWithCapacity:0];
	Button *button;
	for (int i = 0; i < animalArray.count; i ++) {
		dataStorageFood = [storageFood objectForKey:[animalArray objectAtIndex:i]];
		if(dataStorageFood.numOfFood !=0)
		{
			countOfFoodButton ++;
			//动物结婚
			button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:[NSString stringWithFormat:@"food_%d.png",countOfFoodButton] setTarget:self
									   setSelector:@selector(btnPlayerOperationButtonHandlerFeed:) setPriority:0 offsetX:-1 offsetY:2 scale:0.55];
			button.position = ccp(20 + countOfFoodButton*25, 50);
			
			bg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"food_%d.png",countOfFoodButton] ofType:nil] ] ];
			[playerStatusIconTextures addObject:bg];
			
			//button.tag = OPERATION_MARRY;
			[playerButtonContainer addChild: button];
			[playerOperationButtons addObject:button];
			
			// Add by Hunk on 2010-06-24 for memory leak
			//[button release];
		}
	}
}



-(void) btnPlayerOperationButtonHandlerFeed:(Button *)button
{
	[[UIController sharedUIController] switchOperation:button.tag];
	
	selectIndex = [playerOperationButtons indexOfObject:button];
	
	id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(-400, playerButtonContainer.position.y)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveOutFinished)];
	
	id ease = [CCEaseBackIn actionWithAction: actionMove];
	[ease setDuration:0.3];
	
	[playerButtonContainer runAction:[CCSequence actions:ease, actionMoveDone, nil]];
}

-(void) spriteMoveOutFinished
{
	[self setStatusIcon:selectIndex];	
	NSString *index = [[NSNumber numberWithInt:(selectIndex + 1)] stringValue];
	[[UIController sharedUIController] setSelectFoodId:index];
	//btnPlayerOperationFeedButtonHandler for hide the arrow.
	
	id tempAction = [CCCallFuncN actionWithTarget:parentTarget selector:@selector(btnPlayerOperationFeedButtonHandler:)];
	[playerButtonContainer runAction:tempAction];
}
-(void) setStatusIcon: (int)index
{
	CCTexture2D *bg;
	
	if ([[ModelLocator sharedModelLocator] getIsSelfZoo])
	{
		bg = [playerStatusIconTextures objectAtIndex:index];
	}
	CGRect rect = CGRectZero;
	rect.size = bg.contentSize;
	[statusIcon setTexture:bg];
	
	[statusIcon setTextureRect: rect];
	
	[statusIcon setVisible:YES];
}

-(void) btnStatusIconHandlerFeed
{
	[statusIcon setVisible:NO];
	
	id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(0, playerButtonContainer.position.y)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveInFinishedFeed)];
	
	id ease = [CCEaseBackOut actionWithAction: actionMove];
	[ease setDuration:0.3];
	
	if ([[ModelLocator sharedModelLocator] getIsSelfZoo])
	{
		[playerButtonContainer runAction:[CCSequence actions:ease, actionMoveDone, nil]];
	}

	
}
-(void)spriteMoveInFinishedFeed
{
	
}

-(void) dealloc
{
	[playerStatusIconTextures release];
	
	[playerOperationButtons release];
	
	[playerButtonContainer release];
	
	[animalManagerContainer release];
	
	[statusIcon release];
	
//	[parentTarget release];
	
	[super dealloc];
}

@end
