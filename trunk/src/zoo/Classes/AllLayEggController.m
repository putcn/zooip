//
//  AllLayEggController.m
//  zoo
//
//  Created by Gu Lei on 10-5-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AllLayEggController.h"


@implementation AllLayEggController

-(void) execute:(NSObject *)value
{
	//[[ServiceHelper sharedService] getAllBirdAnimalInfo:self andValue:value AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback"];
	
	totalEggCount = 0;
	preEggCount = 0;
	
	//for (int i = 0; i < animals; i++)
//	{
//		totalEggCount++;
//		[layEggController execute:animalID];
//	}
}

-(void) resultCallback:(NSObject *)value
{
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

-(void) finishEgg
{
	preEggCount++;
	
	if (preEggCount >= totalEggCount)
	{
		[self resultCallback:nil];
	}
}

@end
