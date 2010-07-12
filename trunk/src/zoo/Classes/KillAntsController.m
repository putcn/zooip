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
		[[AntController sharedAntController] removeAnt:self.antId setExperience:experience];
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"杀蚂蚁成功"];
		
		// Add by Hunk on 2010-07-09
		((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_currentExp += experience;
		if(((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_currentExp >= ((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_nextLevelExp)
		{
			// 1.当前经验处显示两经验之差
			((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_currentExp = (((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_nextLevelExp - ((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_currentExp);
			
			// 2.下一次升级所需经验处显示下一级升级所需经验值(需要从服务器获取)
			
			// 3.等级加1
			((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_level += 1;
		}
		
		[[GameMainScene sharedGameMainScene] updateUserInfo];
		
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
