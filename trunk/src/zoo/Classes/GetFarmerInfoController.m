//
//  GetFarmerInfoController.m
//  zoo
//
//  Created by Rainbow on 5/10/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "GetFarmerInfoController.h"


@implementation GetFarmerInfoController

-(void) execute:(NSDictionary *)value
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
