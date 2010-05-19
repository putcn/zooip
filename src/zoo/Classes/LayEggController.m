//
//  LayEggController.m
//  zoo
//
//  Created by Gu Lei on 10-5-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LayEggController.h"
#import "AllLayEggController.h"
#import "DataModelAnimal.h"
#import "DataModelEgg.h"

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
	NSDictionary *param = (NSDictionary *)value;
	animalId = [param objectForKey:@"animalId"];
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetLayEggsRemain WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
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
