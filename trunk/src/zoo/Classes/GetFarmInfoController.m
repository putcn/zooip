//
//  GetFarmInfoController.m
//  zoo
//
//  Created by Gu Lei on 10-5-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GetFarmInfoController.h"


@implementation GetFarmInfoController

-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmInfo WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSDictionary *farmDic = [result objectForKey:@"farm"];
	
	DataModelFarmInfo *farmInfo = [[DataEnvironment sharedDataEnvironment] playerFarmInfo];
	
	farmInfo.farm_currentExp = [[farmDic objectForKey:@"currentExp"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmDic objectForKey:@"currentExp"] intValue];
	farmInfo.farm_experience = [[farmDic objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmDic objectForKey:@"experience"] intValue];
	farmInfo.farm_expGainPerDay = [[farmDic objectForKey:@"expGainPerDay"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmDic objectForKey:@"expGainPerDay"] intValue];
	farmInfo.farm_foodEndTime = [[farmDic objectForKey:@"foodEndTime"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmDic objectForKey:@"foodEndTime"] intValue];
	farmInfo.farm_level = [[farmDic objectForKey:@"level"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmDic objectForKey:@"level"] intValue];
	farmInfo.farm_maxNumOfBirds = [[farmDic objectForKey:@"maxNumOfBirds"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmDic objectForKey:@"maxNumOfBirds"] intValue];
	farmInfo.farm_nextLevelExp = [[farmDic objectForKey:@"nextLevelExp"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmDic objectForKey:@"nextLevelExp"] intValue];
	farmInfo.farm_remain = [[farmDic objectForKey:@"remain"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmDic objectForKey:@"remain"] intValue];
	farmInfo.farm_topMaxNumOfBirds = [[farmDic objectForKey:@"topMaxNumOfBirds"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmDic objectForKey:@"topMaxNumOfBirds"] intValue];
	
	farmInfo.farmerId = [[farmDic objectForKey:@"farmerId"] isKindOfClass:[NSNull class]]  ? nil : [farmDic objectForKey:@"farmerId"];
	farmInfo.farmId = [[farmDic objectForKey:@"farmId"] isKindOfClass:[NSNull class]]  ? nil : [farmDic objectForKey:@"farmId"];
	
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
