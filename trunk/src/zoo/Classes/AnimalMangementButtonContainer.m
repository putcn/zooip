//
//  AnimalMangementButtonContainer.m
//  zoo
//
//  Created by Alex Liu on 6/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AnimalMangementButtonContainer.h"


@implementation AnimalMangementButtonContainer


-(id) init
{
	self = [super init];
	
	if (self)
	{
		selectIndex = 0;
		
		playerButtonContainer = [[CCSprite alloc] init];
		[self addChild:playerButtonContainer];
		playerButtonContainer.position = ccp(20, playerButtonContainer.position.y);
		[self addButton];
	}
	
	return self;
}

- (void) addButton
{
	playerOperationButtons = [[NSMutableArray alloc] init];
	
	Button *button;
	
	//动物结婚
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"动物结婚.png" setTarget:self
							   setSelector:@selector(btnAnimalMarryButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(120, 50);
	button.tag = OPERATION_MARRY;
	//button.visible = NO;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
	//结婚管理
	button = [[Button alloc] initWithLabel:@"" setColor:ccc3(0, 0, 0) setFont:@"" setSize:12 setBackground:@"婚姻管理.png" setTarget:self
							   setSelector:@selector(btnAnimalMarryManagementButtonHandler:) setPriority:0 offsetX:-1 offsetY:2 scale:0.75];
	button.position = ccp(160, 50);
	button.tag = OPERATION_MARRY_MANAGEMENT;
	//button.visible = NO;
	[playerButtonContainer addChild: button];
	[playerOperationButtons addObject:button];
	
}

-(void)btnAnimalMarryButtonHandler:(Button *)button
{
	animalManagerContainer = [[AnimalManagerContainer alloc] initWithName:@"animalMarry"];
	[self addChild:animalManagerContainer];
}

-(void)btnAnimalMarryManagementButtonHandler:(Button *)button
{
	animalManagerContainer = [[AnimalManagerContainer alloc] initWithName:@"MarryManagement"];
	[self addChild:animalManagerContainer];
}

-(void) btnPlayerOperationButtonHandler:(Button *)button
{
	[[UIController sharedUIController] switchOperation:button.tag];
	
	selectIndex = [playerOperationButtons indexOfObject:button];
	
	id actionMove = [CCMoveTo actionWithDuration:0.6  position:ccp(-400, playerButtonContainer.position.y)];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveOutFinished)];
	
	id ease = [CCEaseBackIn actionWithAction: actionMove];
	[ease setDuration:0.3];
	
	[playerButtonContainer runAction:[CCSequence actions:ease, actionMoveDone, nil]];
}



@end
