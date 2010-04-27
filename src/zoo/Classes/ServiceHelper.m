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


@implementation ServiceHelper
static ServiceHelper *sharedInst = nil;
static NSString *serviceBaseURL = @"http://zoo.hotpod.jp/fplatform/farmv4/mixi/php/remoteService.php";
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

-(void)requestDone:(ASIFormDataRequest *)request{
	
	NSData *jsonData = [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *result = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:nil];
	if (!result) {
		[self feedBackWithBadFormat:[request responseString]];
		return;
	}
	
	NSLog(@"%@",result);
	
	if ([result objectForKey:@"error_code"]) {
		[self operationError:[result objectForKey:@"error_code"]];
		 return;
	}
	
	ZooNetworkRequestType type = request.requestFlagMark;
	DataEnvironment *dataEnv = [DataEnvironment sharedDataEnvironment];
	NSDictionary *farmer = nil;
	NSDictionary *tempDic = nil;
	
	switch (type) {
		case ZooNetworkRequestgetFarmerInfo:
			farmer = (NSDictionary *)[result objectForKey:@"farmer"];
			dataEnv.antsCurrency = [(NSNumber *)[farmer objectForKey:@"antsCurrency"] intValue];
			dataEnv.farmerId = (NSString *)[farmer objectForKey:@"farmerId"];
			dataEnv.snsUserId = [(NSNumber *)[farmer objectForKey:@"snsUserId"] intValue];
			dataEnv.userName = [farmer objectForKey:@"userName"];
			dataEnv.userImg = [farmer objectForKey:@"userImg"];
			dataEnv.farmPref = [(NSNumber *)[farmer objectForKey:@"farmPref"] intValue];
			dataEnv.fighter = [(NSNumber *)[farmer objectForKey:@"fighter"] intValue];
			dataEnv.isNewUser = [(NSNumber *)[farmer objectForKey:@"newUser"] boolValue];
			dataEnv.haveNewMessage = [(NSNumber *)[farmer objectForKey:@"newMessage"] boolValue];
			dataEnv.goldenEgg = [(NSNumber *)[farmer objectForKey:@"goldenEgg"] intValue];
			dataEnv.haveTurtle = [(NSNumber *)[farmer objectForKey:@"turtle"] boolValue];
			break;
			
			
		case ZooNetworkRequestgetFarmInfo:
			tempDic = (NSDictionary *)[result objectForKey:@"farm"];
			dataEnv.farmId = (NSString *)[tempDic objectForKey:@"farmId"];
			dataEnv.farm_level = [(NSNumber *)[tempDic objectForKey:@"level"] intValue];
			dataEnv.farm_currentExp = [(NSNumber *)[tempDic objectForKey:@"currentExp"] intValue];
			dataEnv.farm_expGainPerDay = [(NSNumber *)[tempDic objectForKey:@"expGainPerDay"] intValue];
			dataEnv.farm_expGainTime = [(NSNumber *)[tempDic objectForKey:@"expGainTime"] intValue];
			dataEnv.farm_experience = [(NSNumber *)[tempDic objectForKey:@"experience"] intValue];
			dataEnv.farm_foodEndTime = [(NSNumber *)[tempDic objectForKey:@"foodEndTime"] intValue];
			dataEnv.farm_maxNumOfBirds = [(NSNumber *)[tempDic objectForKey:@"maxNumOfBirds"] intValue];
			dataEnv.farm_nextLevelExp = [(NSNumber *)[tempDic objectForKey:@"nextLevelExp"] intValue];
			dataEnv.farm_remain = [(NSNumber *)[tempDic objectForKey:@"remain"] intValue];
			dataEnv.farm_topMaxNumOfBirds = [(NSNumber *)[tempDic objectForKey:@"topMaxNumOfBirds"] intValue];
			break;
			
		case ZooNetworkRequestgetAllBirdFarmAnimalInfo:
			if (dataEnv.animals) {
				[(NSMutableArray *)dataEnv.animals removeAllObjects];
			}else {
				dataEnv.animals = [[NSMutableArray alloc] init];
			}

			NSArray *animalArr = (NSArray *)[result objectForKey:@"animals"];
			
			DataModelAnimal *aAnimail;
			NSDictionary *aAnimalDic;
			
			for (NSInteger i = 0; i<[animalArr count]; i++) {
				aAnimail = [[DataModelAnimal alloc] init];
				aAnimalDic = [animalArr objectAtIndex:i];
				
				//aAnimail.flyingSpeed = [[aAnimalDic objectForKey:@"flyingSpeed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"flyingSpeed"] intValue];
				
				aAnimail.adultStage = [[aAnimalDic objectForKey:@"adultStage"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"adultStage"] intValue];
				aAnimail.aliveEdge = [[aAnimalDic objectForKey:@"aliveEdge"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"aliveEdge"] intValue];
				aAnimail.animalName = [[aAnimalDic objectForKey:@"animalName"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"animalName"] intValue];
				aAnimail.animalType = [[aAnimalDic objectForKey:@"animalType"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"animalType"] intValue];
				aAnimail.antsPrice = [[aAnimalDic objectForKey:@"antsPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"antsPrice"] intValue];
				aAnimail.babyStage = [[aAnimalDic objectForKey:@"babyStage"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"babyStage"] intValue];
				aAnimail.baseCycle = [[aAnimalDic objectForKey:@"baseCycle"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"baseCycle"] intValue];
				aAnimail.baseInterval = [[aAnimalDic objectForKey:@"baseInterval"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"baseInterval"] intValue];
				aAnimail.basePrice = [[aAnimalDic objectForKey:@"basePrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"basePrice"] intValue];
				aAnimail.baseYield = [[aAnimalDic objectForKey:@"baseYield"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"baseYield"] intValue];
				aAnimail.birdStage = [[aAnimalDic objectForKey:@"birdStage"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"birdStage"] intValue];
				aAnimail.birdType = [[aAnimalDic objectForKey:@"birdType"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"birdType"] intValue];
				aAnimail.characteristic = [[aAnimalDic objectForKey:@"characteristic"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"characteristic"] intValue];
				aAnimail.coupleId = [[aAnimalDic objectForKey:@"coupleId"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"coupleId"] intValue];
				aAnimail.currentInterval = [[aAnimalDic objectForKey:@"currentInterval"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"currentInterval"] intValue];
				aAnimail.discount = [[aAnimalDic objectForKey:@"discount"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"discount"] intValue];
				aAnimail.eggId = [[aAnimalDic objectForKey:@"eggId"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"eggId"] intValue];
				aAnimail.eggImgId = [[aAnimalDic objectForKey:@"eggImgId"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"eggImgId"] intValue];
				aAnimail.eggPrice = [[aAnimalDic objectForKey:@"eggPrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"eggPrice"] intValue];
				aAnimail.emotion = [[aAnimalDic objectForKey:@"emotion"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"emotion"] intValue];
				aAnimail.experience = [[aAnimalDic objectForKey:@"experience"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"experience"] intValue];
				aAnimail.farmType = [[aAnimalDic objectForKey:@"farmType"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"farmType"] intValue];
				aAnimail.flyingSpeed = [[aAnimalDic objectForKey:@"flyingSpeed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"flyingSpeed"] intValue];
				aAnimail.flyingStep = [[aAnimalDic objectForKey:@"flyingStep"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"flyingStep"] intValue];
				aAnimail.gender = [[aAnimalDic objectForKey:@"gender"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"gender"] intValue];
				aAnimail.hatchTime = [[aAnimalDic objectForKey:@"hatchTime"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"hatchTime"] intValue];
				aAnimail.health = [[aAnimalDic objectForKey:@"health"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"health"] intValue];
				aAnimail.lastOutputTime = [[aAnimalDic objectForKey:@"lastOutputTime"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"lastOutputTime"] intValue];
				aAnimail.level = [[aAnimalDic objectForKey:@"level"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"level"] intValue];
				aAnimail.levelRequired = [[aAnimalDic objectForKey:@"levelRequired"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"levelRequired"] intValue];
				aAnimail.longevity = [[aAnimalDic objectForKey:@"longevity"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"longevity"] intValue];
				aAnimail.originalAnimalId = [[aAnimalDic objectForKey:@"originalAnimalId"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"originalAnimalId"] intValue];
				aAnimail.productId = [[aAnimalDic objectForKey:@"productId"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"productId"] intValue];
				aAnimail.productionFlag = [[aAnimalDic objectForKey:@"productionFlag"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"productionFlag"] intValue];
				aAnimail.runingSpeed = [[aAnimalDic objectForKey:@"runingSpeed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"runingSpeed"] intValue];
				aAnimail.runingStep = [[aAnimalDic objectForKey:@"runingStep"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"runingStep"] intValue];
				aAnimail.speed = [[aAnimalDic objectForKey:@"speed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"speed"] intValue];
				aAnimail.stageEndTime = [[aAnimalDic objectForKey:@"stageEndTime"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"stageEndTime"] intValue];
				aAnimail.status = [[aAnimalDic objectForKey:@"status"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"status"] intValue];
				aAnimail.step = [[aAnimalDic objectForKey:@"step"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"step"] intValue];
				aAnimail.swimmingSpeed = [[aAnimalDic objectForKey:@"swimmingSpeed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"swimmingSpeed"] intValue];
				aAnimail.swimmingStep = [[aAnimalDic objectForKey:@"swimmingStep"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"swimmingStep"] intValue];
				aAnimail.walkToEatSpeed = [[aAnimalDic objectForKey:@"walkToEatSpeed"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"walkToEatSpeed"] intValue];
				aAnimail.walkToEatStep = [[aAnimalDic objectForKey:@"walkToEatStep"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"walkToEatStep"] intValue];
				aAnimail.yield = [[aAnimalDic objectForKey:@"yield"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"yield"] intValue];
				aAnimail.youthStage = [[aAnimalDic objectForKey:@"youthStage"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"youthStage"] intValue];
				aAnimail.zygotePrice = [[aAnimalDic objectForKey:@"zygotePrice"] isKindOfClass:[NSNull class]]  ? 0 : [(NSNumber *)[aAnimalDic objectForKey:@"zygotePrice"] intValue];
				
				aAnimail.animalId = [[aAnimalDic objectForKey:@"animalId"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"animalId"];
				aAnimail.birthday = [[aAnimalDic objectForKey:@"birthday"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"birthday"];
				aAnimail.coupleAnimalId = [[aAnimalDic objectForKey:@"coupleAnimalId"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"coupleAnimalId"];
				aAnimail.description = [[aAnimalDic objectForKey:@"description"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"description"];
				aAnimail.eggDescription = [[aAnimalDic objectForKey:@"eggDescription"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"eggDescription"];
				aAnimail.eggName = [[aAnimalDic objectForKey:@"eggName"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"eggName"];
				aAnimail.eggNameEN = [[aAnimalDic objectForKey:@"eggNameEN"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"eggNameEN"];
				aAnimail.farmId = [[aAnimalDic objectForKey:@"farmId"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"farmId"];
				aAnimail.lastFeedTime = [[aAnimalDic objectForKey:@"lastFeedTime"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"lastFeedTime"];
				aAnimail.marriageDate = [[aAnimalDic objectForKey:@"marriageDate"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"marriageDate"];
				aAnimail.picturePrefix = [[aAnimalDic objectForKey:@"picturePrefix"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"picturePrefix"];
				aAnimail.scientificNameCN = [[aAnimalDic objectForKey:@"scientificNameCN"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"scientificNameCN"];
				aAnimail.scientificNameEN = [[aAnimalDic objectForKey:@"scientificNameEN"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"scientificNameEN"];
				aAnimail.sickStartTime = [[aAnimalDic objectForKey:@"sickStartTime"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"sickStartTime"];
				aAnimail.speedFlag = [[aAnimalDic objectForKey:@"speedFlag"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"speedFlag"];
				aAnimail.virusReleaserId = [[aAnimalDic objectForKey:@"virusReleaserId"] isKindOfClass:[NSNull class]]  ? nil : [aAnimalDic objectForKey:@"virusReleaserId"];
				
				[dataEnv.animals addObject:aAnimail];
			}
			
			//DataModelAnimal *aAni = (DataModelAnimal *)[dataEnv.animals objectAtIndex:2];
			//NSLog(@"ani's yeld is %d",aAni.yield);
			
			
			
			//[dataEnv.animals setArray:(NSArray *)[result objectForKey:@"animals"]];
			break;


		default:
			break;
	}
}

-(void)nativeNetworkError:(ASIFormDataRequest *)request{ //http error, TBD
	NSLog(@"http request error");
}

-(void)feedBackWithBadFormat:(NSString *)callBackString{
	NSLog(@"bad orgnized feedback : %@",callBackString);
}

-(void)operationError:(NSString *)reason{
	NSLog(@"operation Error, with reason : %@",reason);
}


	

-(ASIFormDataRequest *)buildRequestWithType:(ZooNetworkRequestType)type{
	NSURL *url = [NSURL URLWithString:serviceBaseURL];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	request.requestFlagMark = type;
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	
	//set testing uid and pid
	[request setPostValue:@"25313321" forKey:@"uid"];
	[request setPostValue:@"11" forKey:@"pid"];
	
	return request;
}

-(void)getFarmerInfo{
	ASIFormDataRequest *request = [self buildRequestWithType:ZooNetworkRequestgetFarmerInfo];
	[request setPostValue:@"getFarmerInfo" forKey:@"method"];
	[request startAsynchronous];
}

-(void)getFarmInfoWithFarmerId:(NSString *)farmerId AndIsGuarded:(BOOL)isGuarded{
	NSString *strIsGuarded = @"0";
	if (isGuarded) {
		strIsGuarded = @"1";
	}
	
	if (!farmerId) {
		farmerId = [DataEnvironment sharedDataEnvironment].farmerId;
	}
	
	ASIFormDataRequest *request = [self buildRequestWithType:ZooNetworkRequestgetFarmInfo];
	[request setPostValue:@"getFarmInfo" forKey:@"method"];
	[request setPostValue:farmerId forKey:@"farmerId"];
	[request setPostValue:strIsGuarded forKey:@"bodyguard"];
	[request startAsynchronous];
}

-(void)getAllBirdFarmAnimalInfoWithFarmId:(NSString *)farmId AndFarmerId:(NSString *)farmerId{
	
	if (!farmerId) {
		farmerId = [DataEnvironment sharedDataEnvironment].farmerId;
	}
	
	if (!farmId) {
		farmId = [DataEnvironment sharedDataEnvironment].farmId;
	}
	
	ASIFormDataRequest *request = [self buildRequestWithType:ZooNetworkRequestgetAllBirdFarmAnimalInfo];
	[request setPostValue:@"getAllBirdFarmAnimalInfo" forKey:@"method"];
	[request setPostValue:farmerId forKey:@"farmerId"];
	[request setPostValue:farmId forKey:@"farmId"];
	[request startAsynchronous];
}


@end
