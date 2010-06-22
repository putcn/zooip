//
//  FeedProductYieldFoodController.m
//  zoo
//
//  Created by Gu Lei on 10-5-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FeedProductYieldFoodController.h"
#import "FeedbackDialog.h"

@implementation FeedProductYieldFoodController

-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoFeedProductYieldFood WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	//	NSDictionary *result = (NSDictionary *)value;
	
	//	NSInteger experience = [[result objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"experience"] intValue];
	//	[[EggController sharedEggController] removeEgg:eggId setExperience:experience];
	
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];	
	if (code == 0) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"饲料不足"];
	}
	if (code == 1) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"喂食成功"];
	}
	if (code == 2) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"已喂食"];
	}
	if (code == 3) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"产蛋为0，不能喂食"];
	}
	if (code == 4) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"动物不存在"];
	}
	if (code == 5) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"饲料类型不正确"];
	}
	if (code == 6) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"公动物不能喂食"];
	}
	if (code == 7) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"喂多只动物成功"];
	}
	
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
