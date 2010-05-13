//
//  GetAllBirdFarmAnimalInfoController.m
//  zoo
//
//  Created by Gu Lei on 10-5-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GetAllBirdFarmAnimalInfoController.h"


@implementation GetAllBirdFarmAnimalInfoController

-(void) execute:(NSObject *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllBirdFarmAnimalInfo WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
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
