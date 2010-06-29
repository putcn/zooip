//
//  BaseServerController.m
//  zoo
//
//  Created by Gu Lei on 10-5-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BaseServerController.h"
#import "BaseWorkFlowController.h"

@implementation BaseServerController

-(BaseServerController *) initWithWorkFlowController:(BaseWorkFlowController *)controller
{
	if ((self = [super init]))
	{
		workFlowController = controller;
		return self;
	}
	
	return nil;
}

-(void) execute:(NSObject *)value
{
	
}

-(void) resultCallback:(NSObject *)value
{
	if (workFlowController != nil)
	{
		[workFlowController nextStep];
	}
}

-(void) faultCallback:(NSObject *)value
{
	NSLog(@"Server Connection Fail");
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[workFlowController release];
	
	[super dealloc];
}


@end
