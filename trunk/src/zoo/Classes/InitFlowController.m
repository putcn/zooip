//
//  InitFlowController.m
//  zoo
//
//  Created by Gu Lei on 10-5-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InitFlowController.h"
#import "ServerController.h"

@implementation InitFlowController

static NSString *STEP_GET_FARMER_INFO = @"0";
static NSString *STEP_GET_ALL_ANIMAL_INFO = @"1";
static NSString *STEP_EGG = @"2";
static NSString *STEP_GET_ALL_EGG_INFO = @"3";

-(void) start
{
	step = STEP_GET_FARMER_INFO;
	
	ServerController *tempController = [stepControllers objectForKey:step];
	[tempController execute:nil];
}

-(void) nextStep
{
	if (step == STEP_GET_FARMER_INFO)
	{
		step = STEP_GET_ALL_ANIMAL_INFO;
		return;
	}
	else if (step == STEP_GET_ALL_ANIMAL_INFO)
	{
		step = STEP_EGG;
		return;
	}
	else if (step == STEP_EGG)
	{
		step = STEP_GET_ALL_EGG_INFO;
		return;
	}
	else if (step == STEP_GET_ALL_EGG_INFO)
	{
		[self end];
		return;
	}
}

-(void) end
{
	
}

@end
