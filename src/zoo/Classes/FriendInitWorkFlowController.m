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
	GetFarmerInfoController *getFarmerInfoController = (GetFarmerInfoController *) [[GetFarmerInfoController alloc] initWithWorkFlowController:self];
	[self addController:getFarmerInfoController andStep:STEP_GET_FARMER_INFO];
	[getFarmerInfoController release];

	GetFarmInfoController *getFarmInfoController = (GetFarmInfoController *) [[GetFarmInfoController alloc] initWithWorkFlowController:self];
	[self addController:getFarmInfoController andStep:STEP_GET_FARM_INFO];
	[getFarmInfoController release];
	
	GetAllBirdFarmAnimalInfoController *getAllBirdFarmAnimalInfoController =(GetAllBirdFarmAnimalInfoController *) [[GetAllBirdFarmAnimalInfoController alloc] initWithWorkFlowController:self];
	[self addController:getAllBirdFarmAnimalInfoController andStep:STEP_GET_ALL_ANIMAL_INFO];
	[getAllBirdFarmAnimalInfoController release];
	
	AllLayEggController *allLayEggController = (AllLayEggController *) [[AllLayEggController alloc] initWithWorkFlowController: self];
	[self addController:allLayEggController andStep:STEP_GET_ALL_EGG_INFO];
	[allLayEggController release];
	
	GetSnakeOfFarmController *getSnakeOfFarmController =(GetSnakeOfFarmController *) [[GetSnakeOfFarmController alloc]  initWithWorkFlowController:self];
	[self addController:getSnakeOfFarmController andStep:STEP_GET_SNAKE];
	[getSnakeOfFarmController release];
	
	GetDejectaOfFarmController *getDejectaOfFarmController =(GetDejectaOfFarmController *) [[GetDejectaOfFarmController alloc] initWithWorkFlowController:self];
	[self addController:getDejectaOfFarmController andStep:STEP_GET_DEJECTA];
	[getDejectaOfFarmController release];
	
	GetAntOfFarmController *getAntOfFarmController =(GetAntOfFarmController *) [[GetAntOfFarmController alloc] initWithWorkFlowController:self];
	[self addController:getAntOfFarmController andStep:STEP_GET_ANT];
	[getAntOfFarmController release];
	
	GetFarmerDogController *getFarmerDogController =(GetFarmerDogController *) [[GetFarmerDogController alloc] initWithWorkFlowController:self];
	[self addController:getFarmerDogController andStep:STEP_GET_DOG];
	[getFarmerDogController release];
}

-(void) startStep
{
	curStep = STEP_GET_FARMER_INFO;
	
	BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
	[tempController execute:nil];
}

-(void) nextStep
{
	[[GameMainScene sharedGameMainScene] loading:curStep];
	if (curStep == STEP_GET_FARMER_INFO)
	{
		load = [[LoadView alloc] init];
		[load MyLoadingView];
		[load SetLabelString:curStep];
		
		curStep = STEP_GET_FARM_INFO;
		
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmerInfo.farmerId,@"farmerId",
								[[NSNumber alloc] initWithBool:YES],@"bodyguard",nil];
		[tempController execute:params];
		
		return;
	}
	else if (curStep == STEP_GET_FARM_INFO)
	{
		[load SetLabelString:curStep];
		
		curStep = STEP_GET_ALL_ANIMAL_INFO;
		
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmId,@"farmId",nil];
		[tempController execute:params];
		
		return;
	}
	else if (curStep == STEP_GET_ALL_ANIMAL_INFO)
	{
		[load SetLabelString:curStep];
		
		curStep = STEP_GET_ALL_EGG_INFO;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmId,@"farmId",
								[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId, @"viewerId", nil];
		[tempController execute:params];
		return;
	}
	else if (curStep == STEP_GET_ALL_EGG_INFO)
	{
		[load SetLabelString:curStep];
		
		curStep = STEP_GET_SNAKE;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmId,@"farmId",nil];
		[tempController execute:params];
		return;
	}
	else if (curStep == STEP_GET_SNAKE)
	{
		[load SetLabelString:curStep];
		
		curStep = STEP_GET_DEJECTA;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmId,@"farmId",nil];
		[tempController execute:params];
		return;
	}
	else if (curStep == STEP_GET_DEJECTA)
	{
		[load SetLabelString:curStep];
		
		curStep = STEP_GET_ANT;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmId,@"farmId",nil];
		[tempController execute:params];
		return;
		
	}
	else if (curStep == STEP_GET_ANT)
	{
		[load SetLabelString:curStep];
		
		curStep = STEP_GET_DOG;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmerId,@"farmerId",nil];
		[tempController execute:params];
		return;
		
	}
	else if (curStep == STEP_GET_DOG)
	{
		[self endStep];
		
		[load RemoveView];
		[load release];
		
		return;
	}
}

-(void) endStep
{
	
	[[GameMainScene sharedGameMainScene] updateUserInfo];
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

// Add by Hunk on 2010-06-29
-(void)dealloc
{
//	[load release];
	
	[super dealloc];
}


@end
