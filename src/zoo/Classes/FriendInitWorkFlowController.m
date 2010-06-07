//
//  FriendInitWorkFlowController.m
//  zoo
//
//  Created by Gu Lei on 10-6-7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FriendInitWorkFlowController.h"
#import "BaseServerController.h"
#import "AnimalController.h"
#import "ItemController.h"
#import "EggController.h"
#import "SnakeController.h"
#import "DejectaController.h"
#import "AntController.h"
#import "GameMainScene.h"
#import "FeedbackDialog.h"
#import "GetFarmerInfoController.h"
#import "GetFarmInfoController.h"
#import "GetAllBirdFarmAnimalInfoController.h"
#import "AllLayEggController.h"
#import "GetSnakeOfFarmController.h"
#import "GetDejectaOfFarmController.h"
#import "GetAntOfFarmController.h"
#import "GetFarmerDogController.h"

static NSString *STEP_GET_FARMER_INFO = @"0";
static NSString *STEP_GET_FARM_INFO = @"1";
static NSString *STEP_GET_ALL_ANIMAL_INFO = @"2";
static NSString *STEP_GET_ALL_EGG_INFO = @"3";
static NSString *STEP_GET_SNAKE = @"4";
static NSString *STEP_GET_DEJECTA = @"5";
static NSString *STEP_GET_ANT = @"6";
static NSString *STEP_GET_DOG = @"7";

@implementation FriendInitWorkFlowController

-(void) setupStep
{
	GetFarmerInfoController *getFarmerInfoController = [[GetFarmerInfoController alloc] initWithWorkFlowController:self];
	[self addController:getFarmerInfoController andStep:STEP_GET_FARMER_INFO];
	GetFarmInfoController *getFarmInfoController = [[GetFarmInfoController alloc] initWithWorkFlowController:self];
	[self addController:getFarmInfoController andStep:STEP_GET_FARM_INFO];
	GetAllBirdFarmAnimalInfoController *getAllBirdFarmAnimalInfoController = [[GetAllBirdFarmAnimalInfoController alloc] initWithWorkFlowController:self];
	[self addController:getAllBirdFarmAnimalInfoController andStep:STEP_GET_ALL_ANIMAL_INFO];
	AllLayEggController *allLayEggController = [[AllLayEggController alloc] initWithWorkFlowController: self];
	[self addController:allLayEggController andStep:STEP_GET_ALL_EGG_INFO];
	GetSnakeOfFarmController *getSnakeOfFarmController = [[GetSnakeOfFarmController alloc]  initWithWorkFlowController:self];
	[self addController:getSnakeOfFarmController andStep:STEP_GET_SNAKE];
	GetDejectaOfFarmController *getDejectaOfFarmController = [[GetDejectaOfFarmController alloc] initWithWorkFlowController:self];
	[self addController:getDejectaOfFarmController andStep:STEP_GET_DEJECTA];
	GetAntOfFarmController *getAntOfFarmController = [[GetAntOfFarmController alloc] initWithWorkFlowController:self];
	[self addController:getAntOfFarmController andStep:STEP_GET_ANT];
	GetFarmerDogController *getFarmerDogController = [[GetFarmerDogController alloc] initWithWorkFlowController:self];
	[self addController:getFarmerDogController andStep:STEP_GET_DOG];
}

-(void) startStep
{
	curStep = STEP_GET_FARMER_INFO;
	
	BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
	[tempController execute:nil];
}

-(void) nextStep
{
	if (curStep == STEP_GET_FARMER_INFO)
	{
		curStep = STEP_GET_FARM_INFO;
		
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
								[[NSNumber alloc] initWithBool:YES],@"bodyguard",nil];
		[tempController execute:params];
		
		return;
	}
	else if (curStep == STEP_GET_FARM_INFO)
	{
		curStep = STEP_GET_ALL_ANIMAL_INFO;
		
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
		[tempController execute:params];
		
		return;
	}
	else if (curStep == STEP_GET_ALL_ANIMAL_INFO)
	{
		curStep = STEP_GET_ALL_EGG_INFO;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		[tempController execute:nil];
		
		return;
	}
	else if (curStep == STEP_GET_ALL_EGG_INFO)
	{
		curStep = STEP_GET_SNAKE;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
		[tempController execute:params];
		return;
	}
	else if (curStep == STEP_GET_SNAKE)
	{
		curStep = STEP_GET_DEJECTA;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
		[tempController execute:params];
		return;
	}
	else if (curStep == STEP_GET_DEJECTA)
	{
		curStep = STEP_GET_ANT;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
		[tempController execute:params];
		return;
		
	}
	else if (curStep == STEP_GET_ANT)
	{
		curStep = STEP_GET_DOG;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",nil];
		[tempController execute:params];
		return;
		
	}
	else if (curStep == STEP_GET_DOG)
	{
		[self endStep];
		return;
	}
}

-(void) endStep
{
	UILayer *uiLayer = [[UILayer alloc] init];
	FeedbackDialog *feedbackDialog = [[FeedbackDialog alloc] init];
	feedbackDialog.position = ccp(-feedbackDialog.contentSize.width/2,280);
	[[GameMainScene sharedGameMainScene] addChild:uiLayer z:10];
	[[GameMainScene sharedGameMainScene] addChild:feedbackDialog z:100];
	[[EggController sharedEggController] addEggs:[[DataEnvironment sharedDataEnvironment].eggs allKeys]];
	[[ItemController sharedItemController] addItem:@"bowls"];
	[[AnimalController sharedAnimalController] addAnimal:[DataEnvironment sharedDataEnvironment].animalIDs];
	if ([DataEnvironment sharedDataEnvironment].playerFarmerInfo.haveTurtle) {
		[[ItemController sharedItemController] addItem:@"chinemy"];
	}
	if ([[[DataEnvironment sharedDataEnvironment].snakes allKeys] count] > 0) {
		[[SnakeController sharedSnakeController] addSnakes:[[DataEnvironment sharedDataEnvironment].snakes allKeys]];
	}
	if ([[[DataEnvironment sharedDataEnvironment].dejectas allKeys] count] > 0) {
		[[DejectaController sharedDejectaController] addDejectas:[[DataEnvironment sharedDataEnvironment].dejectas allKeys]];
	}
	if ([[[DataEnvironment sharedDataEnvironment].ants allKeys] count] > 0) {
		[[AntController sharedAntController] addAnts:[[DataEnvironment sharedDataEnvironment].ants allKeys]];
	}
	if ([[[DataEnvironment sharedDataEnvironment].dogs allKeys] count] > 0) {
		[[ItemController sharedItemController] addItem:@"dog"];
	}
}

@end