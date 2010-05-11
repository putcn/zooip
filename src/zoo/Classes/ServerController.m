//
//  ServerController.m
//  zoo
//
//  Created by Gu Lei on 10-5-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ServerController.h"


@implementation ServerController

-(ServerController *) initWithWorkFlowController:(WorkFlowController *)controller
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

@end
