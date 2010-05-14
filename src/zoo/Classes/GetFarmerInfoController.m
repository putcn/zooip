//
//  GetFarmerInfoController.m
//  zoo
//
//  Created by Rainbow on 5/10/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "GetFarmerInfoController.h"


@implementation GetFarmerInfoController

-(void) execute:(NSDictionary *)value
{
	NSDictionary *param = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetFarmerInfo WithParameters:param AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	NSDictionary *farmerDic = [result objectForKey:@"farmer"];
	
	DataModelFarmerInfo *farmerInfo = [[DataEnvironment sharedDataEnvironment] playerFarmerInfo];
	
	farmerInfo.antsCurrency = [[farmerDic objectForKey:@"antsCurrency"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"antsCurrency"] intValue];
	farmerInfo.farmPref = [[farmerDic objectForKey:@"farmPref"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"farmPref"] intValue];
	farmerInfo.fighter = [[farmerDic objectForKey:@"fighter"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"fighter"] intValue];
	farmerInfo.goldenEgg = [[farmerDic objectForKey:@"goldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"goldenEgg"] intValue];
	farmerInfo.platformId = [[farmerDic objectForKey:@"platformId"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"platformId"] intValue];
	farmerInfo.snsUserId = [[farmerDic objectForKey:@"snsUserId"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"snsUserId"] intValue];
	
	farmerInfo.farmerId = [[farmerDic objectForKey:@"farmerId"] isKindOfClass:[NSNull class]]  ? nil : [farmerDic objectForKey:@"farmerId"];
	farmerInfo.userImg = [[farmerDic objectForKey:@"userImg"] isKindOfClass:[NSNull class]]  ? nil : [farmerDic objectForKey:@"userImg"];
	farmerInfo.userName = [[farmerDic objectForKey:@"userName"] isKindOfClass:[NSNull class]]  ? nil : [farmerDic objectForKey:@"userName"];
	
	farmerInfo.haveNewMessage = [[farmerDic objectForKey:@"haveNewMessage"] isKindOfClass:[NSNull class]]  ? NO : [(NSNumber *)[farmerDic objectForKey:@"haveNewMessage"] intValue];
	farmerInfo.haveTurtle = [[farmerDic objectForKey:@"haveTurtle"] isKindOfClass:[NSNull class]]  ? NO : [(NSNumber *)[farmerDic objectForKey:@"haveTurtle"] intValue];
	farmerInfo.isNewUser = [[farmerDic objectForKey:@"isNewUser"] isKindOfClass:[NSNull class]]  ? NO : [(NSNumber *)[farmerDic objectForKey:@"isNewUser"] intValue];
	
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
