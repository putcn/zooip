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
	
		// Add by Hunk on 2010-07-09
//		((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_currentExp += experience;
//		
//		if(((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_currentExp >= ((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_nextLevelExp)
//		{
//			// 1.当前经验处显示两经验之差
//			((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_currentExp = (((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_nextLevelExp - ((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_currentExp);
//			
//			// 2.下一次升级所需经验处显示下一级升级所需经验值(需要从服务器获取)
//			
//			// 3.等级加1
//			((DataModelFarmInfo *)[DataEnvironment sharedDataEnvironment].playerFarmInfo).farm_level += 1;
//		}
//		
//		[[GameMainScene sharedGameMainScene] updateUserInfo];
		
		
		
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
