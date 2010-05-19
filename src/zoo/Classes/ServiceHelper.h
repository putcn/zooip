//
//  ServiceHelper.h
//  zoo
//
//  Created by Darcy on 3/30/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

// testing farmer id : A6215BF61A3AF50A8F72F043A1A6A85C
// testing uid : 25313321
// testing pid : 11
// 

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "DataEnvironment.h"
@class ASIFormDataRequest;

typedef enum {
	ZooNetworkRequestNone = 0,
	ZooNetworkRequestgetFarmerInfo,
	ZooNetworkRequestgetFarmInfo,
	ZooNetworkRequestgetAllBirdFarmAnimalInfo,
	ZooNetworkRequestgetSnakesOfFarm,
	ZooNetworkRequestgetAllEggsInfo,
	ZooNetworkRequestgetAntsOfFarm,
	ZooNetworkRequestgetDejectaOfFarm,
	ZooNetworkRequestgetLayEggsRemain,
	ZooNetworkRequestgetFarmerDog,
	ZooNetworkRequestgetFarmerMessage,
	ZooNetworkRequestgetFriendsInfo,
	ZooNetworkRequestgetUserTips,
	ZooNetworkRequestgetAllStorageAnimal,
	ZooNetworkRequestgetAllStorageAuctionAnimal,
	ZooNetworkRequestgetAllStorageProducts,
	ZooNetworkRequestgetStoreZygoteEgg,
	ZooNetworkRequestgetAllStorageFoods,
	ZooNetworkRequestgetAllOriginalAnimal,
	ZooNetworkRequestgetAllFoods,
	ZooNetworkRequestgetAllGoods,
	ZooNetworkRequesttoFeedAllAnimal,
	ZooNetworkRequesttoFeedPowerFoods,
	ZooNetworkRequesttoFeedProductYieldFood
	
} ZooNetworkRequestType;

@interface ServiceHelper : NSObject {
	NSMutableDictionary *CallBacks;
}

+ (ServiceHelper *)sharedService;
- (void) restore;
-(NSString *)getTimeStamp;
/*
-(ASIFormDataRequest *)BuildRequestWithURL:(NSString *)URLString AndRequestFlag:(NSString *)requestFlag AndCallBackScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector;
-(void)connectivityTestWithScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector;
-(void)getFarmInfoWithFarmerId:(NSString *)farmerId AndIsbodyGarded:(BOOL)IsbodyGarded AndScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector;
-(void)getAllBirdFarmAnimalInfoWithFarmId:(NSString *)farmerId AndFarmerId:(NSString *)farmerId AndScope:(id)CallBackDelegate AndSuccessSel:(NSString *)SuccessSelector AndFailedSel:(NSString *)FailedSelector;
*/

-(ASIFormDataRequest *)requestServerForMethod:(ZooNetworkRequestType)methodType WithParameters:(NSDictionary *)parameters AndCallBackScope:(id)callBackDelegate AndSuccessSel:(NSString *)successSelector AndFailedSel:(NSString *)failedSelector;
@end
