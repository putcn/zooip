//
//  FeedPowerFoodsController.m
//  zoo
//
//  Created by Gu Lei on 10-5-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FeedPowerFoodsController.h"
#import "FeedbackDialog.h"

@implementation FeedPowerFoodsController

-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoFeedPowerFoods WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
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
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"动物不存在"];
	}
	if (code == 4) 
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"动物处于饥饿状态，不能喂食"];
	}
	if (code == 5) 
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
