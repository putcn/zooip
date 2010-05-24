//
//  PickEggToStorageController.m
//  zoo
//
//  Created by Gu Lei on 10-5-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PickEggToStorageController.h"
#import "EggController.h"


@implementation PickEggToStorageController

@synthesize eggId;

-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestpickEggsToStorage WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger experience = [[result objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"experience"] intValue];
	[[EggController sharedEggController] removeEgg:eggId setExperience:experience];
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
