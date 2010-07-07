//
//  StealEggsFromFarmController.m
//  zoo
//
//  Created by Rainbow on 6/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "StealEggsFromFarmController.h"
#import "DataModelEgg.h"
#import "DataEnvironment.h"
#import "OperationEndView.h"
#import "EggController.h"


@implementation StealEggsFromFarmController
@synthesize eggId;

-(void)execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequeststealEggsFromFarm WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];

}

-(void)resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSInteger code = [[result objectForKey:@"code"] intValue];
	switch (code) {
		case 1:
		{
			DataModelEgg *dataModelEgg = (DataModelEgg*)[[DataEnvironment sharedDataEnvironment].eggs objectForKey:eggId];
			EggView *eggView = [[EggController sharedEggController].allEggs objectForKey:eggId];
			CGPoint eggPos = eggView.position;
			NSInteger stolenNum = [[result objectForKey:@"numOfStolen"] intValue];
			dataModelEgg.remain = dataModelEgg.remain - stolenNum;
			[[OperationEndView alloc] initWithExperience:0 setPosition: ccp(eggPos.x, eggPos.y+50) setNumber:stolenNum];
			
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"偷蛋成功"];
		}
			break;
		case 2:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"蛋堆所剩无几"];
			break;
		case 3:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"已偷过"];
			break;
		case 4:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"不能连续偷窃"];
			break;
		case 5:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"偷蛋成功"];
			break;
		case 6:
			//code:5 + 掉金币:goldenEgg
			//[[FeedbackDialog sharedFeedbackDialog] addMessage:@"偷蛋成功"];
			break;
		case 0:
			[[FeedbackDialog sharedFeedbackDialog] addMessage:@"偷窃者无金蛋了"];
			break;
		default:
			break;
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
	[eggId release];
	
	[super dealloc];
}


@end
