//
//  BaseWorkFlowController.m
//  zoo
//
//  Created by Gu Lei on 10-5-14.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BaseWorkFlowController.h"


@implementation BaseWorkFlowController

-(void) addController:(BaseServerController *) controller andStep:(NSString *) step
{
	if (stepControllers == nil)
	{
		stepControllers = [[NSMutableDictionary alloc] init];
	}
	
	[stepControllers setObject:controller forKey:step];
}

-(void) setupStep
{
	
}

-(void) startStep
{
	
}

-(void) nextStep
{
	
}

-(void) endStep
{
	
}

-(void) dealloc
{
	// Add by Hunk on 2010-06-29
	[curStep release];
	
	[stepControllers removeAllObjects];
	[stepControllers release];
	
	[super dealloc];
}

@end
