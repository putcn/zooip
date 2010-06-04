//
//  GetAllOriginalAnimalController.m
//  zoo
//
//  Created by Gu Lei on 10-6-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GetAllOriginalAnimalController.h"


@implementation GetAllOriginalAnimalController

-(void) execute:(NSDictionary *)value
{
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllOriginalAnimal WithParameters:nil AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
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
