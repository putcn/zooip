//
//  InitWorkFlowController.m
//  zoo
//
//  Created by Gu Lei on 10-5-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InitWorkFlowController.h"
#import "BaseServerController.h"

static NSString *STEP_GET_FARMER_INFO = @"0";
static NSString *STEP_GET_FARM_INFO = @"1";
static NSString *STEP_GET_ALL_ANIMAL_INFO = @"2";
static NSString *STEP_LAY_EGG = @"3";
static NSString *STEP_GET_ALL_EGG_INFO = @"4";

@implementation InitWorkFlowController

-(void) setupStep
{
	GetFarmerInfoController *getFarmerInfoController = [[GetFarmerInfoController alloc] initWithWorkFlowController:self];
	[self addController:getFarmerInfoController andStep:STEP_GET_FARMER_INFO];
	GetFarmInfoController *getFarmInfoController = [[GetFarmInfoController alloc] initWithWorkFlowController:self];
	[self addController:getFarmInfoController andStep:STEP_GET_FARM_INFO];
	GetAllBirdFarmAnimalInfoController *getAllBirdFarmAnimalInfoController = [[GetAllBirdFarmAnimalInfoController alloc] initWithWorkFlowController:self];
	[self addController:getAllBirdFarmAnimalInfoController andStep:STEP_GET_ALL_ANIMAL_INFO];
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
		
		[self endStep];
		
		return;
	}
	else if (curStep == STEP_GET_ALL_ANIMAL_INFO)
	{
		curStep = STEP_LAY_EGG;
		
		return;
	}
	else if (curStep == STEP_LAY_EGG)
	{
		curStep = STEP_GET_ALL_EGG_INFO;
		return;
	}
	else if (curStep == STEP_GET_ALL_EGG_INFO)
	{
		[self endStep];
		return;
	}
}

-(void) endStep
{
	
}

@end
