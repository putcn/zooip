//
//  ToThrowFireworkController.m
//  zoo
//
//  Created by Rainbow on 6/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ToThrowFireworkController.h"
#import "AnimalController.h"

@implementation ToThrowFireworkController
-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoThrowFirework WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
	
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1) {		
		[[AnimalController sharedAnimalController] scatterAll];
	}
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
