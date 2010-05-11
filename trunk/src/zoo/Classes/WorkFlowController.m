//
//  WorkFlowController.m
//  zoo
//
//  Created by Gu Lei on 10-5-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WorkFlowController.h"

@implementation WorkFlowController

-(void) addController:(ServerController *) controller andStep:(NSString *) step
{
	if (stepControllers == nil)
	{
		stepControllers = [[NSMutableDictionary alloc] initWithCapacity:0];
	}
	
	[stepControllers setObject:controller forKey:step];
}

-(void) start
{
	
}

-(void) nextStep
{
	
}

-(void) end
{
	
}

-(void) dealloc
{
	[stepControllers removeAllObjects];
	[stepControllers release];
	
	[super dealloc];
}

@end
