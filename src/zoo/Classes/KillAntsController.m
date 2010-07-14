//
//  KillAntsController.m
//  zoo
//
//  Created by Gu Lei on 10-5-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "KillAntsController.h"
#import "AntController.h"


#import "BaseServerController.h"
#import "BaseWorkFlowController.h"


@implementation KillAntsController
@synthesize antId;

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
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoKillAnts WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1)
	{
		NSInteger experience = [[result objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"experience"] intValue];
		[[AntController sharedAntController] removeAnt:self.antId setExperience:experience];
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"杀蚂蚁成功"];
		
		// Add by Hunk on 2010-07-14 for updating farm information
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
		[self updateFarmInfoExeCute:params];
	}
	if (code == 2) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"证据不能销毁"];
	}
	if (code == 0) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"没有蚂蚁"];
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
	[antId release];
	
	[super dealloc];
}


@end
