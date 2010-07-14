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

// Add by Hunk on 2010-07-14 for updating farm information
-(void)updateFarmInfoExeCute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmInfo WithParameters:param AndCallBackScope:self AndSuccessSel:@"updateFarmInfoResultCallback:" AndFailedSel:@"faultCallback:"];
}

// Add by Hunk on 2010-07-14 for updating farm information
-(void)updateFarmInfoResultCallback:(NSObject*)value
{
	[[GameMainScene sharedGameMainScene] updateUserInfo];
}

-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestpickEggsToStorage WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1)
	{
		NSInteger experience = [[result objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"experience"] intValue];
		[[EggController sharedEggController] removeEgg:eggId setExperience:experience];
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"收蛋成功"]; 
		
		// Add by Hunk on 2010-07-14 for updating farm information
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
		[self updateFarmInfoExeCute:params];
	}
	if(code == 2)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"该蛋不属于你"];
	}
	if(code == 3)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"收蛋不成功"];
	}
	if(code == 0)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"该蛋不存在"];
	}
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[eggId release];
	
	[super dealloc];
}



@end
