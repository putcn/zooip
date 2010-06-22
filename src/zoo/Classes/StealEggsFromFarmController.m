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
	if (code == 1) {		
		DataModelEgg *dataModelEgg = (DataModelEgg*)[[DataEnvironment sharedDataEnvironment].eggs objectForKey:eggId];
		EggView *eggView = [[EggController sharedEggController].allEggs objectForKey:eggId];
		CGPoint eggPos = eggView.position;
		NSInteger stolenNum = [[result objectForKey:@"numOfStolen"] intValue];
		dataModelEgg.remain = dataModelEgg.remain - stolenNum;
		[[OperationEndView alloc] initWithExperience:0 setPosition: ccp(eggPos.x, eggPos.y+50) setNumber:stolenNum];

		[[FeedbackDialog sharedFeedbackDialog] addMessage:@"偷蛋成功"];
	}
	[super resultCallback:value];
}

-(void)faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}
@end
