//
//  serviceHelper.m
//  zoo
//
//  Created by Darcy on 3/30/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "serviceHelper.h"
#import "ModelLocator.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "DataEnvironment.h"
#import "DataModelAnimal.h"
#import "DataModelEgg.h"
#import "DataModelSnake.h";
#import "DataModelAnt.h"
#import "DataModelDejecta.h"
#import "DataModelDog.h"
#import "DataModelFriendInfo.h"
#import "DataModelUserTips.h"
#import "DataModelStorageFood.h"
#import "DataModelStorageEgg.h"
#import "DataModelStorageZygoteEgg.h"
#import "DataModelOriginalAnimal.h"
#import "DataModelFood.h"
#import "DataModelGood.h"
#import "DataModelStorageAnimal.h"
#import "DataModelStorageAuctionAnimal.h"

@implementation ServiceHelper
static ServiceHelper *sharedInst = nil;
static NSString *ServiceBaseURL = @"http://zoo.hotpod.jp/fplatform/farmv4/mixi/php/remoteService.php";//
//static NSString *testingFarmerId = @"A6215BF61A3AF50A8F72F043A1A6A85C";
//static NSString *testingFarmId = @"163D7A78682082B36872659C7A9DA8F9";

+ (id)sharedService{
    @synchronized( self ) {
        if ( sharedInst == nil ) {
            /* sharedInst set up in init */
            [[self alloc] init];
        }
    }
	
    return sharedInst;
}

- (id)init{
    if ( sharedInst != nil ) {
		
	} else if ( (self = [super init]) ) {
		CallBacks = [[NSMutableDictionary alloc] init];
		sharedInst = self;
		[self restore];
		
	}
	return sharedInst;
}


- (NSUInteger)retainCount{
	return NSUIntegerMax;
}

- (oneway void)release{
}

- (id)retain{
	return sharedInst;
}

- (id)autorelease{
	return sharedInst;
}

- (void) restore{
	
}

-(NSString *)getTimeStamp{
	NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
	return [NSString stringWithFormat:@"%u",timestamp];
}

-(void)requestDone:(ASIFormDataRequest *)request{
	//NSLog(@"feed back for action : %@, is : %@",request.requestFlagMark,[request responseString]);
	
	NSString* response = [request responseString]; 
	NSData *jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
	// TODO DELETE
	//NSLog(response);
	NSDictionary *result = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
	NSLog(@"%@",result);
	NSDictionary *targetCallBack = [CallBacks objectForKey:request.requestFlagMark];
	
	BOOL shouldTriggerErrorHandler = NO;
	
	if ([[result objectForKey:@"error_code"] intValue] == 100) {
		shouldTriggerErrorHandler = YES;
	}
	
	NSInteger code = [[result objectForKey:@"code"] intValue];
	
	switch (request.ZooRequestType) {
		case ZooNetworkRequestgetFarmerInfo:
		{
			NSDictionary *farmerDic = [result objectForKey:@"farmer"];
			NSString* uid = [[request postData] objectForKey:@"uid"];
			NSString* playerUid = [[DataEnvironment sharedDataEnvironment] playerUid];
			if (uid == playerUid) {
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
				
				farmerInfo.haveNewMessage = [[farmerDic objectForKey:@"newMessage"] isKindOfClass:[NSNull class]]  ? NO : [[farmerDic objectForKey:@"newMessage"] boolValue];
				farmerInfo.haveTurtle = [[farmerDic objectForKey:@"turtle"] isKindOfClass:[NSNull class]]  ? NO : [[farmerDic objectForKey:@"turtle"] boolValue];
				farmerInfo.isNewUser = [[farmerDic objectForKey:@"newUser"] isKindOfClass:[NSNull class]]  ? NO : [[farmerDic objectForKey:@"newUser"] boolValue];
				
			}
			DataModelFarmerInfo *farmerInfo = [[DataEnvironment sharedDataEnvironment] friendFarmerInfo];
			
			farmerInfo.antsCurrency = [[farmerDic objectForKey:@"antsCurrency"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"antsCurrency"] intValue];
			farmerInfo.farmPref = [[farmerDic objectForKey:@"farmPref"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"farmPref"] intValue];
			farmerInfo.fighter = [[farmerDic objectForKey:@"fighter"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"fighter"] intValue];
			farmerInfo.goldenEgg = [[farmerDic objectForKey:@"goldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"goldenEgg"] intValue];
			farmerInfo.platformId = [[farmerDic objectForKey:@"platformId"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"platformId"] intValue];
			farmerInfo.snsUserId = [[farmerDic objectForKey:@"snsUserId"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[farmerDic objectForKey:@"snsUserId"] intValue];
			
			farmerInfo.farmerId = [[farmerDic objectForKey:@"farmerId"] isKindOfClass:[NSNull class]]  ? nil : [farmerDic objectForKey:@"farmerId"];
			farmerInfo.userImg = [[farmerDic objectForKey:@"userImg"] isKindOfClass:[NSNull class]]  ? nil : [farmerDic objectForKey:@"userImg"];
			farmerInfo.userName = [[farmerDic objectForKey:@"userName"] isKindOfClass:[NSNull class]]  ? nil : [farmerDic objectForKey:@"userName"];
			
			farmerInfo.haveNewMessage = [[farmerDic objectForKey:@"newMessage"] isKindOfClass:[NSNull class]]  ? NO : [(NSNumber *)[farmerDic objectForKey:@"newMessage"] intValue];
			farmerInfo.haveTurtle = [[farmerDic objectForKey:@"turtle"] isKindOfClass:[NSNull class]]  ? NO : [(NSNumber *)[farmerDic objectForKey:@"turtle"] intValue];
			farmerInfo.isNewUser = [[farmerDic objectForKey:@"newUser"] isKindOfClass:[NSNull class]]  ? NO : [(NSNumber *)[farmerDic objectForKey:@"newUser"] intValue];
		}
			break;
		case ZooNetworkRequestgetFarmInfo:
		{
			NSDictionary *farmDic = [result objectForKey:@"farm"];
			NSString* uid = [[request postData] objectForKey:@"uid"];
			NSString* playerUid = [[DataEnvironment sharedDataEnvironment] playerUid];
			if (uid == playerUid) {
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
				
			}
			DataModelFarmInfo *farmInfo = [[DataEnvironment sharedDataEnvironment] friendFarmInfo];
			
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
		}
			break;
		case ZooNetworkRequestgetAllBirdFarmAnimalInfo:
			// TODO
			break;
		case ZooNetworkRequestgetLayEggsRemain:
		{
			switch (code) {
				case 0:
				{
					// 下蛋成功
					NSDictionary* eggsDic = [[DataEnvironment sharedDataEnvironment] eggs];
					NSArray* eggsArray = [result objectForKey:@"eggs"];
					for (int i = 0; i < [eggsArray count]; i++) {
						NSDictionary* eggDic = [eggsArray objectAtIndex:i];
						DataModelEgg* egg = [[DataModelEgg alloc] init];
						
						egg.birdEggId = [[eggDic objectForKey:@"birdEggId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"birdEggId"];
						egg.farmId = [[eggDic objectForKey:@"farmId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"farmId"];
						egg.lastStoleTime = [[eggDic objectForKey:@"lastStoleTime"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"lastStoleTime"];
						egg.coordinate = [[eggDic objectForKey:@"coordinate"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"coordinate"];
						egg.eggId = [[eggDic objectForKey:@"eggId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggId"];
						//egg.eggName = [[eggDic objectForKey:@"eggName"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggName"];
						egg.eggNameEN = [[eggDic objectForKey:@"eggNameEN"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggNameEN"];
						//egg.eggImgId = [[eggDic objectForKey:@"eggImgId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggImgId"];
						egg.eggDescription = [[eggDic objectForKey:@"eggDescription"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggDescription"];
						
						egg.quantity = [[eggDic objectForKey:@"quantity"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"quantity"] intValue];
						egg.remain = [[eggDic objectForKey:@"remain"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"remain"] intValue];
						egg.numOfZygote = [[eggDic objectForKey:@"numOfZygote"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"numOfZygote"] intValue];
						//egg.eggPrice = [[eggDic objectForKey:@"eggPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"eggPrice"] intValue];
						//egg.zygotePrice = [[eggDic objectForKey:@"zygotePrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"zygotePrice"] intValue];
						
						[eggsDic setValue:egg forKey:[egg birdEggId]];
					}
				}
					break;
				case 1:
					// TODO 动物处于饥饿状态
					break;
				case 2:
				{
					// 动物下蛋时间未到
					NSString* animalId = [[request postData] valueForKey:@"animalId"];
					DataModelAnimal* animal = [[[DataEnvironment sharedDataEnvironment] animals] objectForKey:animalId];
					NSInteger remain = [[result objectForKey:@"remain"] intValue];
					[animal setRemain:remain];
				}
					break;
				case 3:
					// TODO 不存在该动物
					break;
				case 4:
					// TODO 下蛋失败
					break;
				case 5:
					// TODO 公动物不能下蛋
					break;
					
				default:
					break;
			}
		}
			break;
		case ZooNetworkRequestgetAllEggsInfo:
			switch (code) {
				case 1:
				{
					NSArray* eggsArray = [result objectForKey:@"eggs"];
					NSDictionary* eggsDic = [[DataEnvironment sharedDataEnvironment] eggs];
					for (int i = 0; i < [eggsArray count]; i++) {
						NSDictionary* eggDic = (NSDictionary*)[eggsArray objectAtIndex:i];
						DataModelEgg* egg = [[DataModelEgg alloc] init];
						
						egg.birdEggId = [[eggDic objectForKey:@"birdEggId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"birdEggId"];
						egg.farmId = [[eggDic objectForKey:@"farmId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"farmId"];
						egg.lastStoleTime = [[eggDic objectForKey:@"lastStoleTime"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"lastStoleTime"];
						egg.coordinate = [[eggDic objectForKey:@"coordinate"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"coordinate"];
						egg.eggId = [[eggDic objectForKey:@"eggId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggId"];
						egg.eggName = [[eggDic objectForKey:@"eggName"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggName"];
						egg.eggNameEN = [[eggDic objectForKey:@"eggNameEN"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggNameEN"];
						egg.eggImgId = [[eggDic objectForKey:@"eggImgId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggImgId"];
						egg.eggDescription = [[eggDic objectForKey:@"eggDescription"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggDescription"];
						
						egg.quantity = [[eggDic objectForKey:@"quantity"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"quantity"] intValue];
						egg.remain = [[eggDic objectForKey:@"remain"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"remain"] intValue];
						egg.numOfZygote = [[eggDic objectForKey:@"numOfZygote"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"numOfZygote"] intValue];
						egg.eggPrice = [[eggDic objectForKey:@"eggPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"eggPrice"] intValue];
						egg.zygotePrice = [[eggDic objectForKey:@"zygotePrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"zygotePrice"] intValue];
						
						[eggsDic setValue:egg forKey:[egg birdEggId]];
					}
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequestgetSnakesOfFarm:
			switch (code) {
				case 1:
				{
					NSDictionary* snakesDic= [[DataEnvironment sharedDataEnvironment] snakes];
					NSArray* snakesArray = [result objectForKey:@"snakes"];
					for (int i = 0; i < [snakesArray count]; i++) {
						NSDictionary* snakeDic = [snakesArray objectAtIndex:i];
						DataModelSnake* snake = [[DataModelSnake alloc] init];
						
						snake.releaseSnakeId = [[snakeDic objectForKey:@"releaseSnakeId"] isKindOfClass:[NSNull class]]  ? nil : [snakeDic objectForKey:@"releaseSnakeId"];
						snake.snakeReleaser = [[snakeDic objectForKey:@"snakeReleaser"] isKindOfClass:[NSNull class]]  ? nil : [snakeDic objectForKey:@"snakeReleaser"];
						snake.eggId = [[snakeDic objectForKey:@"eggId"] isKindOfClass:[NSNull class]]  ? nil : [snakeDic objectForKey:@"eggId"];
						
						[snakesDic setValue:snake forKey:snake.releaseSnakeId];
					}
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequestgetAntsOfFarm:
			switch (code) {
				case 0:
					// TODO 农场无蚂蚁
					break;
				case 1:
				{
					NSDictionary* antsDic= [[DataEnvironment sharedDataEnvironment] ants];
					NSArray* antsArray = [result objectForKey:@"ants"];
					for (int i = 0; i < [antsArray count]; i++) {
						NSDictionary* antDic = [antsArray objectAtIndex:i];
						DataModelAnt* ant = [[DataModelAnt alloc] init];
						
						ant.releaseAntsId = [[antDic objectForKey:@"releaseAntsId"] isKindOfClass:[NSNull class]]  ? nil : [antDic objectForKey:@"releaseAntsId"];
						ant.antsReleaser = [[antDic objectForKey:@"antsReleaser"] isKindOfClass:[NSNull class]]  ? nil : [antDic objectForKey:@"antsReleaser"];
						
						[antsDic setValue:ant forKey:ant.releaseAntsId];
					}
					
				}
					break;
				default:
					//TODO
					break;
			}
			break;
		case ZooNetworkRequestgetDejectaOfFarm:
			switch (code) {
				case 0:
					// TODO 农场无便便
					break;
				case 1:
				{
					NSDictionary* dejectasDic= [[DataEnvironment sharedDataEnvironment] dejectas];
					NSArray* dejectasArray = [result objectForKey:@"dejectas"];
					for (int i = 0; i < [dejectasArray count]; i++) {
						NSDictionary* dejectaDic = [dejectasArray objectAtIndex:i];
						DataModelDejecta* dejecta = [[DataModelDejecta alloc] init];
						
						dejecta.dejectaId = [[dejectaDic objectForKey:@"dejectaId"] isKindOfClass:[NSNull class]]  ? nil : [dejectaDic objectForKey:@"dejectaId"];
						
						dejecta.coordinateX = [[dejectaDic objectForKey:@"coordinateX"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dejectaDic objectForKey:@"coordinateX"] intValue];
						dejecta.coordinateY = [[dejectaDic objectForKey:@"coordinateY"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dejectaDic objectForKey:@"coordinateY"] intValue];
						
						[dejectasDic setValue:dejecta forKey:dejecta.dejectaId];
					}
					
				}
					break;
				default:
					break;
			}
			break;
		case ZooNetworkRequestgetFarmerDog:
			switch (code) {
				case 0:
					// TODO 无狗
					break;
				case 1:
				{
					NSDictionary* dogsDic= [[DataEnvironment sharedDataEnvironment] dogs];
					NSArray* dogsArray = [result objectForKey:@"dogs"];
					for (int i = 0; i < [dogsArray count]; i++) {
						NSDictionary* dogDic = [dogsArray objectAtIndex:i];
						DataModelDog* dog = [[DataModelDog alloc] init];
						
						dog.farmerDogId = [[dogDic objectForKey:@"farmerDogId"] isKindOfClass:[NSNull class]]  ? nil : [dogDic objectForKey:@"farmerDogId"];
						dog.goodsId = [[dogDic objectForKey:@"goodsId"] isKindOfClass:[NSNull class]]  ? nil : [dogDic objectForKey:@"goodsId"];
						dog.statusEndTime = [[dogDic objectForKey:@"statusEndTime"] isKindOfClass:[NSNull class]]  ? nil : [dogDic objectForKey:@"statusEndTime"];
						dog.endTime = [[dogDic objectForKey:@"endTime"] isKindOfClass:[NSNull class]]  ? nil : [dogDic objectForKey:@"endTime"];
						dog.goodsDuration = [[dogDic objectForKey:@"goodsDuration"] isKindOfClass:[NSNull class]]  ? nil : [dogDic objectForKey:@"goodsDuration"];
						dog.picturePrefix = [[dogDic objectForKey:@"picturePrefix"] isKindOfClass:[NSNull class]]  ? nil : [dogDic objectForKey:@"picturePrefix"];
						dog.goodsPicture = [[dogDic objectForKey:@"goodsPicture"] isKindOfClass:[NSNull class]]  ? nil : [dogDic objectForKey:@"goodsPicture"];
						dog.goodsName = [[dogDic objectForKey:@"goodsName"] isKindOfClass:[NSNull class]]  ? nil : [dogDic objectForKey:@"goodsName"];
						dog.goodsDescription = [[dogDic objectForKey:@"goodsDescription"] isKindOfClass:[NSNull class]]  ? nil : [dogDic objectForKey:@"goodsDescription"];
						
						dog.status = [[dogDic objectForKey:@"status"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dogDic objectForKey:@"status"] boolValue];
						dog.probability = [[dogDic objectForKey:@"probability"] isKindOfClass:[NSNull class]]  ? 0.0 : [(NSNumber *)[dogDic objectForKey:@"probability"] floatValue];
						dog.loseGoldenEgg = [[dogDic objectForKey:@"loseGoldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dogDic objectForKey:@"loseGoldenEgg"] intValue];
						dog.level = [[dogDic objectForKey:@"level"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dogDic objectForKey:@"level"] intValue];
						dog.speed = [[dogDic objectForKey:@"speed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dogDic objectForKey:@"speed"] intValue];
						dog.step = [[dogDic objectForKey:@"step"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dogDic objectForKey:@"step"] intValue];
						dog.aliveEdge = [[dogDic objectForKey:@"aliveEdge"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dogDic objectForKey:@"aliveEdge"] intValue];
						
						[dogsDic setValue:dog forKey:dog.farmerDogId];
					}
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequestgetFarmerMessage:
			// TODO DELETE
			//"code:1 + message + farmer + farmerId + snsUserId + platformId + userName + userImg + farmPref + fighter + expirationDate + newUser + antsCurrency + goldenEgg
			//code:0 无动态信息
			//code:2 该用户不存在"
			switch (code) {
				case 0:
					// TODO 无动态信息
					break;
				case 1:
					// TODO
					break;
				case 2:
					// TODO 该用户不存在
					break;
				default:
					// TODO
					break;
			}

			break;
		case ZooNetworkRequestgetFriendsInfo:
			switch (code) {
				case 0:
					// TODO 无任何好友信息
					break;
				case 1:
				{
					NSDictionary* friendInfosDic= [[DataEnvironment sharedDataEnvironment] friendInfos];
					NSArray* friendInfosArray = [result objectForKey:@"usersInfo"];
					for (int i = 0; i < [friendInfosArray count]; i++) {
						NSDictionary* friendInfoDic = [friendInfosArray objectAtIndex:i];
						DataModelFriendInfo* friendInfo = [[DataModelFriendInfo alloc] init];
						
						friendInfo.farmId = [[friendInfoDic objectForKey:@"farmId"] isKindOfClass:[NSNull class]]  ? nil : [friendInfoDic objectForKey:@"farmId"];
						friendInfo.farmerId = [[friendInfoDic objectForKey:@"farmerId"] isKindOfClass:[NSNull class]]  ? nil : [friendInfoDic objectForKey:@"farmerId"];
						friendInfo.userName = [[friendInfoDic objectForKey:@"userName"] isKindOfClass:[NSNull class]]  ? nil : [friendInfoDic objectForKey:@"userName"];
						friendInfo.tinyurl = [[friendInfoDic objectForKey:@"tinyurl"] isKindOfClass:[NSNull class]]  ? nil : [friendInfoDic objectForKey:@"tinyurl"];
						friendInfo.uid = [[friendInfoDic objectForKey:@"uid"] isKindOfClass:[NSNull class]]  ? nil : [friendInfoDic objectForKey:@"uid"];
						
						friendInfo.experience = [[friendInfoDic objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[friendInfoDic objectForKey:@"experience"] intValue];
						
						[friendInfosDic setValue:friendInfo forKey:friendInfo.farmerId];
					}
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequestgetUserTips:
		{
			NSDictionary* userTipsesDic = [[DataEnvironment sharedDataEnvironment] userTipses];
			DataModelUserTips* userTips = [[DataModelUserTips alloc] init];
				
			userTips.snsUserId = [[userTipsesDic objectForKey:@"snsUserId"] isKindOfClass:[NSNull class]]  ? nil : [userTipsesDic objectForKey:@"farmId"];
			
			userTips.egg = [[userTipsesDic objectForKey:@"egg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[userTipsesDic objectForKey:@"egg"] boolValue];
			userTips.shit = [[userTipsesDic objectForKey:@"shit"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[userTipsesDic objectForKey:@"shit"] boolValue];
			userTips.snake = [[userTipsesDic objectForKey:@"snake"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[userTipsesDic objectForKey:@"snake"] boolValue];
			userTips.ant = [[userTipsesDic objectForKey:@"ant"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[userTipsesDic objectForKey:@"ant"] boolValue];
			
			[userTipsesDic setValue:userTips forKey:userTips.snsUserId];
		}
			break;
		case ZooNetworkRequestgetAllStorageFoods:
			switch (code) {
				case 0:
					// TODO 仓库无任何饲料
					break;
				case 1:
				{
					NSDictionary* storageFoodsDic= [[DataEnvironment sharedDataEnvironment] storageFoods];
					NSArray* storageFoodsArray = [result objectForKey:@"foods"];
					for (int i = 0; i < [storageFoodsArray count]; i++) {
						NSDictionary* storageFoodDic = [storageFoodsArray objectAtIndex:i];
						DataModelStorageFood* storageFood = [[DataModelStorageFood alloc] init];
						
						storageFood.foodStorageId = [[storageFoodDic objectForKey:@"foodStorageId"] isKindOfClass:[NSNull class]]  ? nil : [storageFoodDic objectForKey:@"foodStorageId"];
						storageFood.foodId = [[storageFoodDic objectForKey:@"foodId"] isKindOfClass:[NSNull class]]  ? nil : [storageFoodDic objectForKey:@"foodId"];
						storageFood.foodName = [[storageFoodDic objectForKey:@"foodName"] isKindOfClass:[NSNull class]]  ? nil : [storageFoodDic objectForKey:@"foodName"];
						storageFood.foodImg = [[storageFoodDic objectForKey:@"foodImg"] isKindOfClass:[NSNull class]]  ? nil : [storageFoodDic objectForKey:@"foodImg"];
						
						storageFood.numOfFood = [[storageFoodDic objectForKey:@"numOfFood"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[storageFoodDic objectForKey:@"numOfFood"] intValue];
						storageFood.foodPower = [[storageFoodDic objectForKey:@"foodPower"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[storageFoodDic objectForKey:@"foodPower"] intValue];
						
						[storageFoodsDic setValue:storageFood forKey:storageFood.foodStorageId];
					}
					
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequeststealEggsFromFarm:
			switch (code) {
				case 5:
				{
					DataModelFarmerInfo* playerFarmerInfo = [[DataEnvironment sharedDataEnvironment] playerFarmerInfo];
					playerFarmerInfo.goldenEgg -= [[result objectForKey:@"goldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"goldenEgg"] intValue];
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequesttoReleaseSnake:
			switch (code) {
				case 5:
				{
					DataModelFarmerInfo* playerFarmerInfo = [[DataEnvironment sharedDataEnvironment] playerFarmerInfo];
					playerFarmerInfo.goldenEgg -= [[result objectForKey:@"goldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"goldenEgg"] intValue];
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequesttoReleaseAnts:
			switch (code) {
				case 5:
				{
					DataModelFarmerInfo* playerFarmerInfo = [[DataEnvironment sharedDataEnvironment] playerFarmerInfo];
					playerFarmerInfo.goldenEgg -= [[result objectForKey:@"goldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"goldenEgg"] intValue];
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequesttoThrowFirework:
			switch (code) {
				case 5:
				{
					DataModelFarmerInfo* playerFarmerInfo = [[DataEnvironment sharedDataEnvironment] playerFarmerInfo];
					playerFarmerInfo.goldenEgg -= [[result objectForKey:@"goldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"goldenEgg"] intValue];
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequestpickEggsToStorage:
		case ZooNetworkRequesttoKillAnts:
		case ZooNetworkRequesttoKillSnake:
		case ZooNetworkRequesttoCureAnimal:
		case ZooNetworkRequesttoClearDejecta:
			switch (code) {
				case 1:
					// 收蛋／杀蚂蚁／杀蛇／治疗动物／清理便便成功
				{
					// TODO 需要返回code:1的例子
					DataModelFarmerInfo* playerFarmerInfo = [[DataEnvironment sharedDataEnvironment] playerFarmerInfo];
					
					playerFarmerInfo.experience += [[result objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"experience"] intValue];
					playerFarmerInfo.goldenEgg += [[result objectForKey:@"goldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"goldenEgg"] intValue];
					if ([result valueForKey:@"level"] != nil) {
						playerFarmerInfo.level = [[result objectForKey:@"level"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"level"] intValue];
						playerFarmerInfo.nextLevelExp = [[result objectForKey:@"nextLevelExp"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"nextLevelExp"] intValue];
						playerFarmerInfo.experience = [[result objectForKey:@"currentExp"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"currentExp"] intValue];
					}
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequestgetAllStorageAnimal:
			switch (code)
			{
				case 1:
				{
					NSDictionary* storageAnimals= [DataEnvironment sharedDataEnvironment].storageAnimals;
					NSArray* sArray = [result objectForKey:@"storageAnimals"];
					for (int i = 0; i < [sArray count]; i++)
					{
						NSDictionary* dic = [sArray objectAtIndex:i];
						DataModelStorageAnimal *obj = [[DataModelStorageAnimal alloc] init];
						
						obj.adultBirdStorageId = [[dic objectForKey:@"adultBirdStorageId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"adultBirdStorageId"];
						obj.originalAnimalId = [[dic objectForKey:@"originalAnimalId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"originalAnimalId"];
						
						obj.amount = [[dic objectForKey:@"amount"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"amount"] intValue];
						
						[storageAnimals setValue:obj forKey:obj.originalAnimalId];
					}
					break;
				}
				default:
				{
					break;
				}
			}
			break;
		case ZooNetworkRequestgetAllStorageAuctionAnimal:
			switch (code)
			{
				case 1:
				{
					NSDictionary* storageAuctionAnimals= [DataEnvironment sharedDataEnvironment].storageAuctionAnimals;
					NSArray* sArray = [result objectForKey:@"storageAnimals"];
					for (int i = 0; i < [sArray count]; i++)
					{
						NSDictionary* dic = [sArray objectAtIndex:i];
						DataModelStorageAuctionAnimal *obj = [[DataModelStorageAuctionAnimal alloc] init];
						
						obj.auctionBirdStorageId = [[dic objectForKey:@"auctionBirdStorageId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"auctionBirdStorageId"];
						obj.animalId = [[dic objectForKey:@"animalId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"animalId"];
						obj.originalAnimalId = [[dic objectForKey:@"originalAnimalId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"originalAnimalId"];
						
						[storageAuctionAnimals setValue:obj forKey:obj.animalId];
					}
					break;
				}
				default:
				{
					break;
				}
			}
			break;
		case ZooNetworkRequestremoveAnimal:
			switch (code) {
				case 1:
					// 删除动物成功
				{
					// TODO 删除动物
					DataModelFarmerInfo* playerFarmerInfo = [[DataEnvironment sharedDataEnvironment] playerFarmerInfo];
					
					playerFarmerInfo.goldenEgg += [[result objectForKey:@"goldenEgg"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[result objectForKey:@"goldenEgg"] intValue];
				}
					break;
				default:
					// TODO
					break;
			}
			break;
		case ZooNetworkRequestgetAllStorageProducts:
		{
			//Clear the data first
			NSMutableDictionary* clearDic = [[DataEnvironment sharedDataEnvironment] storageEggs];
			[clearDic removeAllObjects];
			switch (code) {
				case 1:
				{
					// 所有蛋信息
					NSMutableDictionary* sDic = [[DataEnvironment sharedDataEnvironment] storageEggs];
					NSArray* sArray = [result objectForKey:@"eggs"];
					for (int i = 0; i < [sArray count]; i++) {
						NSDictionary* dic = [sArray objectAtIndex:i];
						DataModelStorageEgg* obj = [[DataModelStorageEgg alloc] init];
						
						obj.eggStorageId = [[dic objectForKey:@"eggStorageId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"eggStorageId"];
						obj.eggId = [[dic objectForKey:@"eggId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"eggId"];
						obj.eggName = [[dic objectForKey:@"eggName"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"eggName"];
						obj.eggNameEN = [[dic objectForKey:@"eggNameEN"] isKindOfClass:[NSNull class]]? nil: [dic objectForKey:@"eggNameEN"];
						obj.eggImgId = [[dic objectForKey:@"eggImgId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"eggImgId"];
						obj.eggDescription = [[dic objectForKey:@"eggDescription"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"eggDescription"];
						
						obj.numOfProduct = [[dic objectForKey:@"numOfProduct"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"numOfProduct"] intValue];
						obj.numOfStolen = [[dic objectForKey:@"numOfStolen"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"numOfStolen"] intValue];
						obj.eggPrice = [[dic objectForKey:@"eggPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"eggPrice"] intValue];
						
						[sDic setValue:obj forKey:obj.eggStorageId];
					}
				}
					break;
				default:
					break;
			}
			break;
		}
		case ZooNetworkRequestgetAllStorageZygoteEgg:
			switch (code) {
				case 1:
				{
					// 所有受精蛋信息
					NSDictionary* sDic= [[DataEnvironment sharedDataEnvironment] storageZygoteEggs];
					NSArray* sArray = [result objectForKey:@"eggs"];
					for (int i = 0; i < [sArray count]; i++) {
						NSDictionary* dic = [sArray objectAtIndex:i];
						DataModelStorageZygoteEgg* obj = [[DataModelStorageZygoteEgg alloc] init];
						
						obj.zygoteStorageId = [[dic objectForKey:@"zygoteStorageId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"zygoteStorageId"];
						obj.eggId = [[dic objectForKey:@"eggId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"eggId"];
						obj.eggName = [[dic objectForKey:@"eggName"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"eggName"];
						obj.eggNameEN = [[dic objectForKey:@"eggNameEN"] isKindOfClass:[NSNull class]]? nil: [dic objectForKey:@"eggNameEN"];
						obj.originalAnimalId = [[dic objectForKey:@"originalAnimalId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"originalAnimalId"];
						obj.zygoteBirthday = [[dic objectForKey:@"zygoteBirthday"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"zygoteBirthday"];
						
						obj.baseYield = [[dic objectForKey:@"baseYield"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"baseYield"] intValue];
						obj.incubatingTime = [[dic objectForKey:@"incubatingTime"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"incubatingTime"] intValue];
						obj.zygoteGender = [[dic objectForKey:@"zygoteGender"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"zygoteGender"] intValue];
						obj.status = [[dic objectForKey:@"status"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"status"] intValue];
						obj.eggPrice = [[dic objectForKey:@"eggPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"eggPrice"] intValue];
						
						[sDic setValue:obj forKey:obj.zygoteStorageId];
					}
				}
					break;
				default:
					break;
			}
			break;
		case ZooNetworkRequestgetAllOriginalAnimal:
			switch (code) {
				case 1:
				{
					// 原始动物信息
					NSDictionary* sDic= [[DataEnvironment sharedDataEnvironment] originalAnimals];
					NSArray* sArray = [result objectForKey:@"originalAnimals"];
					for (int i = 0; i < [sArray count]; i++) {
						NSDictionary* dic = [sArray objectAtIndex:i];
						DataModelOriginalAnimal* obj = [[DataModelOriginalAnimal alloc] init];
						
						obj.originalAnimalId = [[dic objectForKey:@"originalAnimalId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"originalAnimalId"];
						obj.scientificNameCN = [[dic objectForKey:@"scientificNameCN"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"scientificNameCN"];
						obj.scientificNameEN = [[dic objectForKey:@"scientificNameEN"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"scientificNameEN"];
						obj.productId = [[dic objectForKey:@"productId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"productId"];
						obj.picturePrefix = [[dic objectForKey:@"picturePrefix"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"picturePrefix"];
						obj.description = [[dic objectForKey:@"description"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"description"];
						
						obj.hatchTime = [[dic objectForKey:@"hatchTime"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"hatchTime"] intValue];
						obj.babyStage = [[dic objectForKey:@"babyStage"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"babyStage"] intValue];
						obj.youthStage = [[dic objectForKey:@"youthStage"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"youthStage"] intValue];
						obj.adultStage = [[dic objectForKey:@"adultStage"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"adultStage"] intValue];
						obj.baseYield = [[dic objectForKey:@"baseYield"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"baseYield"] intValue];
						obj.baseCycle = [[dic objectForKey:@"baseCycle"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"baseCycle"] intValue];
						obj.baseInterval = [[dic objectForKey:@"baseInterval"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"baseInterval"] intValue];
						obj.basePrice = [[dic objectForKey:@"basePrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"basePrice"] intValue];
						obj.antsPrice = [[dic objectForKey:@"antsPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"antsPrice"] intValue];
						obj.levelRequired = [[dic objectForKey:@"levelRequired"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"levelRequired"] intValue];
						obj.birdType = [[dic objectForKey:@"birdType"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"birdType"] intValue];
						obj.aliveEdge = [[dic objectForKey:@"aliveEdge"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"aliveEdge"] intValue];
						obj.step = [[dic objectForKey:@"step"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"step"] intValue];
						obj.speed = [[dic objectForKey:@"speed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"speed"] intValue];
						obj.flyingStep = [[dic objectForKey:@"flyingStep"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"flyingStep"] intValue];
						obj.flyingSpeed = [[dic objectForKey:@"flyingSpeed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"flyingSpeed"] intValue];
						obj.swimmingStep = [[dic objectForKey:@"swimmingStep"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"swimmingStep"] intValue];
						obj.swimmingSpeed = [[dic objectForKey:@"swimmingSpeed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"swimmingSpeed"] intValue];
						obj.runingStep = [[dic objectForKey:@"runingStep"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"runingStep"] intValue];
						obj.runingSpeed = [[dic objectForKey:@"runingSpeed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"runingSpeed"] intValue];
						obj.walkToEatStep = [[dic objectForKey:@"walkToEatStep"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"walkToEatStep"] intValue];
						obj.walkToEatSpeed = [[dic objectForKey:@"walkToEatSpeed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"walkToEatSpeed"] intValue];
						
						[sDic setValue:obj forKey:obj.originalAnimalId];
					}
				}
					break;
				default:
					break;
			}
			break;
		case ZooNetworkRequestgetAllFoods:
			switch (code) {
				case 1:
				{
					// 商店所有食物信息
					NSMutableDictionary* sDic= [[DataEnvironment sharedDataEnvironment] foods];
					NSArray* sArray = [result objectForKey:@"foods"];
					for (int i = 0; i < [sArray count]; i++) {
						NSDictionary* dic = [sArray objectAtIndex:i];
						DataModelFood* obj = [[DataModelFood alloc] init];
						
						obj.foodPower = [[dic objectForKey:@"foodPower"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"foodPower"];
						obj.foodName = [[dic objectForKey:@"foodName"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"foodName"];
						obj.foodImg = [[dic objectForKey:@"foodImg"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"foodImg"];
						
						NSInteger foodId = [[dic objectForKey:@"foodId"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"foodId"] intValue];
						obj.foodId = [NSString stringWithFormat:@"%d", foodId];
						obj.foodPrice = [[dic objectForKey:@"foodPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"foodPrice"] intValue];
						obj.antsRequired = [[dic objectForKey:@"antsRequired"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"antsRequired"] intValue];
						
						[sDic setObject:obj forKey:obj.foodId];
					}
				}
					break;
				default:
					break;
			}
			break;
		case ZooNetworkRequestgetAllGoods:
			switch (code) {
				case 1:
				{
					// 商店所有道具信息
					NSDictionary* sDic= [[DataEnvironment sharedDataEnvironment] goods];
					NSArray* sArray = [result objectForKey:@"goods"];
					for (int i = 0; i < [sArray count]; i++) {
						NSDictionary* dic = [sArray objectAtIndex:i];
						DataModelGood* obj = [[DataModelGood alloc] init];
						
						obj.goodsId = [[dic objectForKey:@"goodsId"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"goodsId"];
						obj.capability1 = [[dic objectForKey:@"capability1"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"capability1"];
						obj.capability2 = [[dic objectForKey:@"capability2"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"capability2"];
						obj.goodsPicture = [[dic objectForKey:@"goodsPicture"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"goodsPicture"];
						obj.goodsName = [[dic objectForKey:@"goodsName"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"goodsName"];
						obj.goodsDescription = [[dic objectForKey:@"goodsDescription"] isKindOfClass:[NSNull class]]  ? nil : [dic objectForKey:@"goodsDescription"];
						obj.goodsType = [[dic objectForKey:@"goodsType"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"goodsType"] intValue];
						obj.goodsDuration = [[dic objectForKey:@"goodsDuration"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"goodsDuration"] intValue];
						obj.currencyType = [[dic objectForKey:@"currencyType"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"currencyType"] intValue];
						obj.goodsAntsPrice = [[dic objectForKey:@"goodsAntsPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"goodsAntsPrice"] intValue];
						obj.goodsGoldenPrice = [[dic objectForKey:@"goodsGoldenPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"goodsGoldenPrice"] intValue];
						obj.levelRequired = [[dic objectForKey:@"levelRequired"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[dic objectForKey:@"levelRequired"] intValue];
						
						[sDic setValue:obj forKey:obj.goodsId];
					}
				}
					break;
				default:
					break;
			}
			break;
			
		default:
			break;
	}
	
	if(shouldTriggerErrorHandler){
		[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onfailed"]) withObject:@"auth error"];
	}else {
		[[targetCallBack objectForKey:@"delegate"] performSelector:NSSelectorFromString([targetCallBack objectForKey:@"onsuccess"]) withObject:result];
	}
	
	//clean up
	[CallBacks removeObjectForKey:request.requestFlagMark];
}

-(void)requestWentWrong:(ASIFormDataRequest *)request{ //http error, TBD
	[CallBacks removeObjectForKey:request.requestFlagMark];
	NSLog(@"request %@ went wrong with status code %d, and feedback body %@",request.requestFlagMark, [request responseStatusCode], [request responseString]);
}

-(ASIFormDataRequest *)requestServerForMethod:(ZooNetworkRequestType)methodType WithParameters:(NSDictionary *)parameters AndCallBackScope:(id)callBackDelegate AndSuccessSel:(NSString *)successSelector AndFailedSel:(NSString *)failedSelector{
	NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:callBackDelegate, @"delegate", successSelector, @"onsuccess", failedSelector, @"onfailed", nil];
	[tempDic retain];
	
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:ServiceBaseURL]];
	request.requestFlagMark = [self getTimeStamp];
	request.ZooRequestType = methodType;
	
	[CallBacks setObject:tempDic forKey:request.requestFlagMark];
	
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	[request setRequestMethod:@"POST"];
	
	NSString *uid;
	if (methodType == ZooNetworkRequestgetFarmerInfo && [[ModelLocator sharedModelLocator] getIsSelfZoo] == NO)
	{
		uid = [DataEnvironment sharedDataEnvironment].friendUid;
	}
	else
	{
		uid = [DataEnvironment sharedDataEnvironment].playerUid;
	}
	NSString *pid = [DataEnvironment sharedDataEnvironment].pid;
	
	//set testing uid and pid
	[request setPostValue:uid forKey:@"uid"];
	[request setPostValue:pid forKey:@"pid"];
	
	[request setUseCookiePersistance:NO];
	
	NSString *methodName;
	
	switch (methodType) {
		case ZooNetworkRequestgetFarmerInfo:
			methodName = @"getFarmerInfo";
			break;
		case ZooNetworkRequestgetFarmInfo:
			methodName = @"getFarmInfo";
			break;
		case ZooNetworkRequestgetAllBirdFarmAnimalInfo:
			methodName = @"getAllBirdFarmAnimalInfo";
			break;
		case ZooNetworkRequestgetSnakesOfFarm:
			methodName = @"getSnakesOfFarm";
			break;
		case ZooNetworkRequestgetAllEggsInfo:
			methodName = @"getAllEggsInfo";
			break;
		case ZooNetworkRequestgetAntsOfFarm:
			methodName = @"getAntsOfFarm";
			break;
		case ZooNetworkRequestgetDejectaOfFarm:
			methodName = @"getDejectaOfFarm";
			break;
		case ZooNetworkRequestgetLayEggsRemain:
			methodName = @"getLayEggsRemain";
			break;
		case ZooNetworkRequestgetFarmerDog:
			methodName = @"getFarmerDog";
			break;
		case ZooNetworkRequestgetFarmerMessage:
			methodName = @"getFarmerMessage";
			break;
		case ZooNetworkRequestgetFriendsInfo:
			methodName = @"getFriendsInfo";
			break;
		case ZooNetworkRequestgetUserTips:
			methodName = @"getUserTips";
			break;
		case ZooNetworkRequestgetAllStorageFoods:
			methodName = @"getAllStorageFoods";
			break;
		case ZooNetworkRequesttoFeedAllAnimal:
			methodName = @"toFeedAllAnimal";
			break;
		case ZooNetworkRequesttoFeedPowerFoods:
			methodName = @"toFeedPowerFoods";
			break;
		case ZooNetworkRequesttoFeedProductYieldFood:
			methodName = @"toFeedProductYieldFood";
			break;
		case ZooNetworkRequestpickEggsToStorage:
			methodName = @"pickEggsToStorage";
			break;
		case ZooNetworkRequeststealEggsFromFarm:
			methodName = @"stealEggsFromFarm";
			break;
		case ZooNetworkRequesttoReleaseSnake:
			methodName = @"toReleaseSnake";
			break;
		case ZooNetworkRequesttoReleaseAnts:
			methodName = @"toReleaseAnts";
			break;
			
		case ZooNetworkRequesttoThrowFirework:
			methodName = @"toThrowFirework";
			break;
			
		case ZooNetworkRequesttoKillAnts:
			methodName = @"toKillAnts";
			break;
			
		case ZooNetworkRequesttoKillSnake:
			methodName = @"toKillSnake";
			break;
		case ZooNetworkRequesttoCureAnimal:
			methodName = @"toCureAnimal";
			break;
		case ZooNetworkRequesttoClearDejecta:
			methodName = @"toClearDejecta";
			break;
			
		case ZooNetworkRequestgetAllStorageAnimal:
			methodName = @"getAllStorageAnimal";
			break;
			
		case ZooNetworkRequestgetAllStorageAuctionAnimal:
			methodName = @"getAllStorageAuctionAnimal";
			break;
			
		case ZooNetworkRequestaddAuctionAnimalToFarm:
			methodName = @"addAuctionAnimalToFarm";
			break;
			
		case ZooNetworkRequestaddAnimalToFarm:
			methodName = @"addAnimalToFarm";
			break;
			
		case ZooNetworkRequestupdateAnimalNameInfo:
			methodName = @"updateAnimalNameInfo";
			break;
		case ZooNetworkRequesttoMateAnimal:
			methodName = @"toMateAnimal";
			break;
			
		case ZooNetworkRequesttoFeedFemaleAnimal:
			methodName = @"toFeedFemaleAnimal";
			break;
			
		case ZooNetworkRequesttoDisbandMateAnimal:
			methodName = @"toDisbandMateAnimal";
			break;
			
		case ZooNetworkRequestremoveAnimal:
			methodName = @"removeAnimal";
			break;
			
		case ZooNetworkRequestexpansionInfo:
			methodName = @"expansionInfo";
			break;
			
		case ZooNetworkRequestexpansionFarm:
			methodName = @"expansionFarm";
			break;
			
		case ZooNetworkRequestgetAllStorageProducts:
			methodName = @"getAllStorageProducts";
			break;
			
		case ZooNetworkRequestgetAllStorageZygoteEgg:
			methodName = @"getAllStorageZygoteEgg";
			break;
			
		case ZooNetworkRequesttoIncubatingEgg:
			methodName = @"toIncubatingEgg";
			break;
			
		case ZooNetworkRequesttoSellZygoteEgg:
			methodName = @"toSellZygoteEgg";
			break;
			
		case ZooNetworkRequesttoSellProduct:
			methodName = @"toSellProduct";
			break;
			
		case ZooNetworkRequesttoSellAllZygoteEgg:
			methodName = @"toSellAllZygoteEgg";
			break;
			
		case ZooNetworkRequesttoSellAllProducts:
			methodName = @"toSellAllProducts";
			break;
			
		case ZooNetworkRequestgetAllOriginalAnimal:
			methodName = @"getAllOriginalAnimal";
			break;
			
		case ZooNetworkRequestgetAllFoods:
			methodName = @"getAllFoods";
			break;
			
		case ZooNetworkRequestgetAllGoods:
			methodName = @"getAllGoods";
			break;
			
		case ZooNetworkRequestbuyFoodByGoldenEgg:
			methodName = @"buyFoodByGoldenEgg";
			break;
			
		case ZooNetworkRequestbuyFoodByAnts:
			methodName = @"buyFoodByAnts";
			break;
			
		case ZooNetworkRequestbuyAnimalByGoldenEgg:
			methodName = @"buyAnimalByGoldenEgg";
			break;
			
		case ZooNetworkRequestbuyAnimalByAnts:
			methodName = @"buyAnimalByAnts";
			break;
			
		case ZooNetworkRequestbuyTurtleByAnts:
			methodName = @"buyTurtleByAnts";
			break;
			
		case ZooNetworkRequestbuyDogByAnts:
			methodName = @"buyDogByAnts";
			break;
			
		case ZooNetworkRequestgetAuctionPageList:
			methodName = @"getAuctionPageList";
			break;
			
		case ZooNetworkRequestgetBidInfo:
			methodName = @"getBidInfo";
			break;
			
		case ZooNetworkRequestbidAuction:
			methodName = @"bidAuction";
			break;
		case ZooNetworkRequestsellBird:
			methodName = @"sellBird";
			break;
			
		case ZooNetworkRequestsellZygote:
			methodName = @"sellZygote";
			break;
			
		case ZooNetworkRequestgetAuctionBack:
			methodName = @"getAuctionBack";
			break;
			
		case ZooNetworkRequestdealAuction:
			methodName = @"dealAuction";
			break;
			
		case ZooNetworkRequestcleanAuction:
			methodName = @"cleanAuction";
			break;
			
		case ZooNetworkRequestgetMyAuction:
			methodName = @"getMyAuction";
			break;
			
		case ZooNetworkRequestgetMyBid:
			methodName = @"getMyBid";
			break;
			
		case ZooNetworkRequestupdateNewUser:
			methodName = @"updateNewUser";
			break;
			
		case ZooNetworkRequesttoGetIncubatingTime:
			methodName = @"toGetIncubatingTime";
			break;
			
		case ZooNetworkRequestaddNewUserInfo:
			methodName = @"addNewUserInfo";
			break;
			
			
		default:
			break;
	}
	
	[request setPostValue:methodName forKey:@"method"];
	
	NSArray *paraKeys = [parameters allKeys];
	if ([paraKeys count]>0) {
		for(NSInteger i = 0; i < [paraKeys count]; i++) {
			[request setPostValue:[parameters objectForKey:[paraKeys objectAtIndex:i]] forKey:[paraKeys objectAtIndex:i]];
		}
	}
	[request startAsynchronous];
	NSLog(@"%@",parameters);
	return request;
}

@end
