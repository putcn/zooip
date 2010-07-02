//
//  GetFarmInfoController.m
//  zoo
//
//  Created by Gu Lei on 10-5-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GetFarmInfoController.h"
#import "FeedbackDialog.h"

@implementation GetFarmInfoController

-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmInfo WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
//	if(code == 1)
//	{
//		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"成功获得农场信息"];
//	}
//	else if(code == 0)
//	{
//		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"获得农场信息失败"];
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
