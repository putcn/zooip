//
//  PlayerInitWorkFlowController.m
//  zoo
//
//  Created by Gu Lei on 10-5-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayerInitWorkFlowController.h"
#import "BaseServerController.h"
#import "GetFarmerInfoController.h"
#import "GetFarmInfoController.h"
#import "GetAllBirdFarmAnimalInfoController.h"
#import "LayEggController.h"
#import "AllLayEggController.h"
#import "GetSnakeOfFarmController.h"
#import "GetDejectaOfFarmController.h"
#import "GetAntOfFarmController.h"
#import "GetFarmerDogController.h"
#import "GetAllOriginalAnimalController.h"
#import "GetFriendsInfoController.h"
#import "AnimalController.h"
#import "ItemController.h"
#import "EggController.h"
#import "SnakeController.h"
#import "DejectaController.h"
#import "AntController.h"
#import "GameMainScene.h"
#import "FeedbackDialog.h"

static NSString *STEP_GET_FARMER_INFO = @"0";
static NSString *STEP_GET_FARM_INFO = @"1";
static NSString *STEP_GET_ALL_ANIMAL_INFO = @"2";
static NSString *STEP_LAY_EGG = @"3";
static NSString *STEP_GET_ALL_EGG_INFO = @"4";
static NSString *STEP_GET_SNAKE = @"5";
static NSString *STEP_GET_DEJECTA = @"6";
static NSString *STEP_GET_ANT = @"7";
static NSString *STEP_GET_DOG = @"8";
static NSString *STEP_GET_ALL_ORIGINAL_ANIMAL = @"9";
static NSString *STEP_GET_ALL_FRIENDS_INFO = @"10";

@implementation PlayerInitWorkFlowController

-(void) setupStep
{
	GetFarmerInfoController *getFarmerInfoController =(GetFarmerInfoController *)[[GetFarmerInfoController alloc] initWithWorkFlowController:self];
	[self addController:getFarmerInfoController andStep:STEP_GET_FARMER_INFO];
	[getFarmerInfoController release];
	
	GetFarmInfoController *getFarmInfoController =(GetFarmInfoController*) [[GetFarmInfoController alloc] initWithWorkFlowController:self];
	[self addController:getFarmInfoController andStep:STEP_GET_FARM_INFO];
	[getFarmInfoController release];
	
	GetAllBirdFarmAnimalInfoController *getAllBirdFarmAnimalInfoController =(GetAllBirdFarmAnimalInfoController *) [[GetAllBirdFarmAnimalInfoController alloc] initWithWorkFlowController:self];
	[self addController:getAllBirdFarmAnimalInfoController andStep:STEP_GET_ALL_ANIMAL_INFO];
	[getAllBirdFarmAnimalInfoController release];
	
	LayEggController *layEggController =(LayEggController *)[[LayEggController alloc] initWithWorkFlowController:self];
	[self addController:layEggController andStep:STEP_LAY_EGG];
	[layEggController release];
	
	AllLayEggController *allLayEggController = (AllLayEggController *) [[AllLayEggController alloc] initWithWorkFlowController: self];
	[self addController:allLayEggController andStep:STEP_GET_ALL_EGG_INFO];
	[allLayEggController release];
	
	GetSnakeOfFarmController *getSnakeOfFarmController =(GetSnakeOfFarmController *) [[GetSnakeOfFarmController alloc]  initWithWorkFlowController:self];
	[self addController:getSnakeOfFarmController andStep:STEP_GET_SNAKE];
	[getSnakeOfFarmController release];
	
	GetDejectaOfFarmController *getDejectaOfFarmController =(GetDejectaOfFarmController *) [[GetDejectaOfFarmController alloc] initWithWorkFlowController:self];
	[self addController:getDejectaOfFarmController andStep:STEP_GET_DEJECTA];
	[getDejectaOfFarmController release];
	
	GetAntOfFarmController *getAntOfFarmController = (GetAntOfFarmController *) [[GetAntOfFarmController alloc] initWithWorkFlowController:self];
	[self addController:getAntOfFarmController andStep:STEP_GET_ANT];	[getAntOfFarmController release];
	
	GetFarmerDogController *getFarmerDogController = (GetFarmerDogController *) [[GetFarmerDogController alloc] initWithWorkFlowController:self];
	[self addController:getFarmerDogController andStep:STEP_GET_DOG];
	[getFarmerDogController release];
	
	GetAllOriginalAnimalController *getAllOriginalAnimalController = (GetAllOriginalAnimalController *) [[GetAllOriginalAnimalController alloc] initWithWorkFlowController:self];
	[self addController:getAllOriginalAnimalController andStep:STEP_GET_ALL_ORIGINAL_ANIMAL];
	[getAllOriginalAnimalController release];
	
	GetFriendsInfoController *getFriendsInfoController = (GetFriendsInfoController *) [[GetFriendsInfoController alloc] initWithWorkFlowController:self];
	[self addController:getFriendsInfoController andStep:STEP_GET_ALL_FRIENDS_INFO];
	[getFriendsInfoController release];
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
		
		curStep = STEP_LAY_EGG;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		[tempController execute:nil];
		
		return;
	}
	else if (curStep == STEP_LAY_EGG)
	{
		curStep = STEP_GET_ALL_EGG_INFO;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",
								[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId, @"viewerId", nil];
		[tempController execute:params];
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
//	else if (curStep == STEP_GET_DOG)
//	{
//		curStep = STEP_GET_ALL_ORIGINAL_ANIMAL;
//		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
//		[tempController execute:nil];
//		return;
//	}
	else if (curStep == STEP_GET_DOG)
	{
		curStep = STEP_GET_ALL_FRIENDS_INFO;
		BaseServerController *tempController = (BaseServerController *)[stepControllers objectForKey:curStep];
		NSString *uids = [[DataEnvironment sharedDataEnvironment].friendIDs componentsJoinedByString:@","];
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uids,@"uids",nil];
		[tempController execute:params];
		return;
	}
	else if (curStep == STEP_GET_ALL_FRIENDS_INFO)
	{
		[self endStep];
		
		return;
	}
}

-(void) endStep
{
	[[GameMainScene sharedGameMainScene] finishLoading];
	[[GameMainScene sharedGameMainScene] updateUserInfo];
	[[EggController sharedEggController] addEggs:[[DataEnvironment sharedDataEnvironment].eggs allKeys]];
	[[ItemController sharedItemController] addItem:@"bowls"];
	//[[AnimalController sharedAnimalController] addAnimal:[DataEnvironment sharedDataEnvironment].animalIDs];
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
