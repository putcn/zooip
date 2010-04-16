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
} ZooNetworkRequestType;

@interface ServiceHelper : NSObject {
	
}

+ (ServiceHelper *)sharedService;
- (void)restore;
-(void)requestDone:(ASIFormDataRequest *)request;
-(void)nativeNetworkError:(ASIFormDataRequest *)request;
-(void)feedBackWithBadFormat:(NSString *)callBackString;
-(void)operationError:(NSString *)reason;


-(ASIFormDataRequest *)buildRequestWithType:(ZooNetworkRequestType)type;
-(void)getFarmerInfo;
-(void)getFarmInfoWithFarmerId:(NSString *)farmerId AndIsGuarded:(BOOL)isGuarded;
-(void)getAllBirdFarmAnimalInfoWithFarmId:(NSString *)farmId AndFarmerId:(NSString *)farmerId;

@end
