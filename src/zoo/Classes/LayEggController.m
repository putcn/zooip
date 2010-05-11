//
//  LayEggController.m
//  zoo
//
//  Created by Gu Lei on 10-5-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LayEggController.h"


@implementation LayEggController

-(void) execute:(NSObject *)value
{
	//[[ServiceHelper sharedService] getAllBirdAnimalInfo:self andValue:value AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback"];
}

-(void) resultCallback:(NSObject *)value
{
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
