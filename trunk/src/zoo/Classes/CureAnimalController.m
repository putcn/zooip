//
//  CureAnimalController.m
//  zoo
//
//  Created by Gu Lei on 10-5-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CureAnimalController.h"
#import "AnimalController.h"

@implementation CureAnimalController
@synthesize animalId;

-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoCureAnimal WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1) {		
		[[AnimalController sharedAnimalController] cureAnimal:animalId];
	}
	
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
