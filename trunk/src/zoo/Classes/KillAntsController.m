//
//  KillAntsController.m
//  zoo
//
//  Created by Gu Lei on 10-5-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "KillAntsController.h"
#import "AntController.h"


@implementation KillAntsController
@synthesize antId;


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
		[[AntController sharedAntController] removeAnt:antId setExperience:experience];
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"杀蚂蚁成功"];
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

@end
