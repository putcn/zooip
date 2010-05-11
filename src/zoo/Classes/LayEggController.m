//
//  LayEggController.m
//  zoo
//
//  Created by Gu Lei on 10-5-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LayEggController.h"


@implementation LayEggController

-(LayEggController *) initWithAllEggController:(AllLayEggController *)controller
{
	if ((self = [super init]))
	{
		allLayEggController = controller;
		return self;
	}
	
	return nil;
}

-(void) execute:(NSObject *)value
{
	//[[ServiceHelper sharedService] getAllBirdAnimalInfo:self andValue:value AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback"];
}

-(void) resultCallback:(NSObject *)value
{
	[allLayEggController finishEgg];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
