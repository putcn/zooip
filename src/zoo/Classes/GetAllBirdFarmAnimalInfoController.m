//
//  GetAllBirdFarmAnimalInfoController.m
//  zoo
//
//  Created by Gu Lei on 10-5-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GetAllBirdFarmAnimalInfoController.h"
#import "FeedbackDialog.h"
#import "AnimalController.h"
@implementation GetAllBirdFarmAnimalInfoController

-(void) execute:(NSObject *)value
{
	NSDictionary *params = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllBirdFarmAnimalInfo WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;	
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if(code == 1)
	{
		[[AnimalController sharedAnimalController] addAnimal:[DataEnvironment sharedDataEnvironment].animalIDs];
	}
//	else if(code == 0)
//	{
//		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"获得动物信息失败"];
//	}
	
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	
	
	[super dealloc];
}


@end
