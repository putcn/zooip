//
//  ClearDejectaController.m
//  zoo
//
//  Created by Gu Lei on 10-5-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ClearDejectaController.h"
#import "DejectaController.h"
#import "DataEnvironment.h"


@implementation ClearDejectaController
@synthesize dejectaId;

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
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoClearDejecta WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1)
	{
		NSInteger experience = [[result objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"experience"] intValue];
		[[DejectaController sharedDejectaController] removeDejecta:self.dejectaId setExperience:experience];
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"成功清除粪便"];
	
		// Add by Hunk on 2010-07-14 for updating farm information
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
		[self updateFarmInfoExeCute:params];	
		
	}
	if(code == 0)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"粪便已经清除"];
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
	[dejectaId release];
	
	[super dealloc];
}


@end
