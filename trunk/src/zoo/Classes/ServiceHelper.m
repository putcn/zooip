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
			// TODO
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
						
						[eggsDic setValue:egg forKey:[egg eggId]];
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
