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
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"放炮仗成功"];
	}
	if(code == 2)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"做坏事数量超标"];
	}
	if(code == 5)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"掉金币"];
	}
	if(code == 6)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"偷窃者无金蛋"];
	}
	if(code == 0)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"农场炮仗数量超标"];
	}
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
