//
//  PickEggToStorageController.m
//  zoo
//
//  Created by Gu Lei on 10-5-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PickEggToStorageController.h"
#import "EggController.h"


@implementation PickEggToStorageController

@synthesize eggId;

-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestpickEggsToStorage WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	if (code == 1)
	{
		NSInteger experience = [[result objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"experience"] intValue];
		[[EggController sharedEggController] removeEgg:eggId setExperience:experience];
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"收蛋成功"]; 
	}
	if(code == 2)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"该蛋不属于你"];
	}
	if(code == 3)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"收蛋不成功"];
	}
	if(code == 0)
	{
		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"该蛋不存在"];
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
	[eggId release];
	
	[super dealloc];
}



@end
