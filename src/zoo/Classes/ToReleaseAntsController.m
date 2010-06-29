//
//  ToReleaseAntsController.m
//  zoo
//
//  Created by Rainbow on 6/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ToReleaseAntsController.h"
#import "DataModelAnt.h"
#import "DataEnvironment.h"
#import "AntController.h"


@implementation ToReleaseAntsController


-(void)execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequesttoReleaseAnts WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];

}

-(void)resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1) {		
		NSString *antId = [result objectForKey:@"releaseAntsId"];
		DataModelAnt *dataModelAnt = [[DataModelAnt alloc] init];
		dataModelAnt.releaseAntsId = antId;
		[[DataEnvironment sharedDataEnvironment].snakes setObject:dataModelAnt forKey:antId];
		[[AntController sharedAntController] addAnts:[NSArray arrayWithObject:antId]];
		
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"放蚂蚁成功"];
	}
	if(code == 2)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"做坏事数量超标"];
	}
	if(code == 3)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"超过农场最大的蚂蚁数"];
	}
	if(code == 4)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不能在自己农场放蚂蚁"];
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
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"农场蚂蚁数量超标"];
	}
	[super resultCallback:value];
}

-(void)faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	
	
	[super dealloc];
}


@end
