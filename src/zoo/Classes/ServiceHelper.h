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
	ZooNetworkRequestgetAllStorageFoods,
	ZooNetworkRequesttoFeedAllAnimal,
	ZooNetworkRequesttoFeedPowerFoods,
	ZooNetworkRequesttoFeedProductYieldFood,
	ZooNetworkRequestpickEggsToStorage,
	ZooNetworkRequeststealEggsFromFarm,
	ZooNetworkRequesttoReleaseSnake,
	ZooNetworkRequesttoReleaseAnts,
	ZooNetworkRequesttoThrowFirework,
	ZooNetworkRequesttoKillAnts,
	ZooNetworkRequesttoKillSnake,
	ZooNetworkRequesttoCureAnimal,
	ZooNetworkRequesttoClearDejecta,
	ZooNetworkRequestgetAllStorageAnimal,
	ZooNetworkRequestgetAllStorageAuctionAnimal,
	ZooNetworkRequestaddAuctionAnimalToFarm,
	ZooNetworkRequestaddAnimalToFarm,
	ZooNetworkRequestupdateAnimalNameInfo,
	ZooNetworkRequesttoMateAnimal,
	ZooNetworkRequesttoFeedFemaleAnimal,
	ZooNetworkRequesttoDisbandMateAnimal,
	ZooNetworkRequestremoveAnimal,
	ZooNetworkRequestexpansionInfo,
	ZooNetworkRequestexpansionFarm,
	ZooNetworkRequestgetAllStorageProducts,
	ZooNetworkRequestgetAllStorageZygoteEgg,
	ZooNetworkRequesttoIncubatingEgg,
	ZooNetworkRequesttoSellZygoteEgg,
	ZooNetworkRequesttoSellProduct,
	ZooNetworkRequesttoSellAllZygoteEgg,
	ZooNetworkRequesttoSellAllProducts,
	ZooNetworkRequestgetAllOriginalAnimal,
	ZooNetworkRequestgetAllFoods,
	ZooNetworkRequestgetAllGoods,
	ZooNetworkRequestbuyFoodByGoldenEgg,
	ZooNetworkRequestbuyFoodByAnts,
	ZooNetworkRequestbuyAnimalByGoldenEgg,
	ZooNetworkRequestbuyAnimalByAnts,
	ZooNetworkRequestbuyTurtleByAnts,
	ZooNetworkRequestbuyDogByAnts,
	ZooNetworkRequestgetAuctionPageList,
	ZooNetworkRequestgetBidInfo,
	ZooNetworkRequestbidAuction,
	ZooNetworkRequestsellBird,
	ZooNetworkRequestsellZygote,
	ZooNetworkRequestgetAuctionBack,
	ZooNetworkRequestdealAuction,
	ZooNetworkRequestcleanAuction,
	ZooNetworkRequestgetMyAuction,
	ZooNetworkRequestgetMyBid,
	ZooNetworkRequestupdateNewUser,
	ZooNetworkRequesttoGetIncubatingTime,
	ZooNetworkRequestaddNewUserInfo
	
} ZooNetworkRequestType;

@interface ServiceHelper : NSObject {
	NSMutableDictionary *CallBacks;
}

+ (ServiceHelper *)sharedService;
- (void) restore;
-(NSString *)getTimeStamp;
- (BOOL)checkNetwork;

-(ASIFormDataRequest *)requestServerForMethod:(ZooNetworkRequestType)methodType WithParameters:(NSDictionary *)parameters AndCallBackScope:(id)callBackDelegate AndSuccessSel:(NSString *)successSelector AndFailedSel:(NSString *)failedSelector;
@end
