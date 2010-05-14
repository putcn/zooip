//
//  GetAllBirdFarmAnimalInfoController.m
//  zoo
//
//  Created by Gu Lei on 10-5-10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GetAllBirdFarmAnimalInfoController.h"


@implementation GetAllBirdFarmAnimalInfoController

-(void) execute:(NSObject *)value
{
	NSDictionary *params = (NSDictionary *)value;
	[[ServiceHelper sharedService] requestServerForMethod:ZooNetworkRequestgetAllBirdFarmAnimalInfo WithParameters:params AndCallBackScope:self AndSuccessSel:@"resultCallback:" AndFailedSel:@"faultCallback:"];
}

-(void) resultCallback:(NSObject *)value
{
	NSDictionary *result = (NSDictionary *)value;
	DataEnvironment *dataEnv = [DataEnvironment sharedDataEnvironment];
	
	NSArray *animalArr = (NSArray *)[result objectForKey:@"animals"];
	
	DataModelAnimal *aAnimail;
	NSDictionary *aAnimalDic;
	
	for (NSInteger i = 0; i<[animalArr count]; i++) {
		aAnimail = [[DataModelAnimal alloc] init];
		aAnimalDic = [animalArr objectAtIndex:i];
		
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

		
		[dataEnv.animals setValue:aAnimail forKey:aAnimail.animalId];
		[dataEnv.animalIDs addObject:aAnimail.animalId];
	}
	NSLog(@"%@",dataEnv.animals);
	NSLog(@"%@",dataEnv.animalIDs);
	
	[super resultCallback:value];
}

-(void) faultCallback:(NSObject *)value
{
	[super faultCallback:value];
}

@end
