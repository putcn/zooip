//
//  serviceHelper.m
//  zoo
//
//  Created by Darcy on 3/30/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "serviceHelper.h"
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


@implementation ServiceHelper
static ServiceHelper *sharedInst = nil;
static NSString *ServiceBaseURL = @"http://zoo.hotpod.jp/fplatform/farmv4/mixi/php/remoteService.php";
static NSString *testingFarmerId = @"A6215BF61A3AF50A8F72F043A1A6A85C";
static NSString *testingFarmId = @"163D7A78682082B36872659C7A9DA8F9";

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
	
	NSData *jsonData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
	// TODO DELETE
	NSLog([request responseString]);
	NSDictionary *result = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
	NSDictionary *targetCallBack = [CallBacks objectForKey:request.requestFlagMark];
	
	BOOL shouldTriggerErrorHandler = NO;
	
	if ([[result objectForKey:@"error_code"] intValue] == 100) {
		shouldTriggerErrorHandler = YES;
	}
	
	NSInteger code = [[result objectForKey:@"code"] intValue];
	
	switch (request.ZooRequestType) {
		case ZooNetworkRequestgetFarmerInfo:
			//todo
			break;
		case ZooNetworkRequestgetFarmInfo:
			// TODO
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
						//egg.eggNameEN = [[eggDic objectForKey:@"eggNameEN"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggNameEN"];
						//egg.eggImgId = [[eggDic objectForKey:@"eggImgId"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggImgId"];
						egg.eggDescription = [[eggDic objectForKey:@"eggDescription"] isKindOfClass:[NSNull class]]  ? nil : [eggDic objectForKey:@"eggDescription"];
						
						egg.quantity = [[eggDic objectForKey:@"quantity"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"quantity"] intValue];
						egg.remain = [[eggDic objectForKey:@"remain"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"remain"] intValue];
						egg.numOfZygote = [[eggDic objectForKey:@"numOfZygote"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"numOfZygote"] intValue];
						//egg.eggPrice = [[eggDic objectForKey:@"eggPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"eggPrice"] intValue];
						//egg.zygotePrice = [[eggDic objectForKey:@"zygotePrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[eggDic objectForKey:@"zygotePrice"] intValue];
						
						[eggsDic setValue:egg forKey:[egg eggId]];
					}
				}
					break;
				case 1:
					// TODO 动物处于饥饿状态
					break;
				case 2:
				{
					// 动物下蛋时间未到
					// TODO 可以得到postData吗？
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
			// TODO DELETE
			// "code:1 + usersInfo + farmId + farmerId + name + tinyurl + experience + uid
			// code:0 无任何好友信息"
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

	//set testing uid and pid
	[request setPostValue:@"25313321" forKey:@"uid"];
	[request setPostValue:@"11" forKey:@"pid"];
	
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
