//
//  DataModelAnimal.h
//  zoo
//
//  Created by Darcy on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataModelCommon.h"


@interface DataModelAnimal : DataModelCommon {
	NSInteger adultStage; //240
	NSInteger aliveEdge; //6
	NSString *animalId; //4F00A3DB79CE6712DCF99E8B2BCEF84F
//	NSInteger animalName; //1
	NSString *animalName;
	NSInteger animalType; //5
	NSInteger antsPrice; //0
	NSInteger babyStage; //18
	NSInteger baseCycle; //30
	NSInteger baseInterval; //3
	NSInteger basePrice; //8708
	NSInteger baseYield; //27
	NSInteger birdStage; //3
	NSInteger birdType; //1
	NSString *birthday; //"2010-03-14 00:38:05"
	NSInteger characteristic; //0
	NSString *coupleAnimalId; 
	NSInteger coupleId; //0
	NSInteger currentInterval; //8
	NSString *description;
	NSInteger discount; //100
	NSString *eggDescription; 
	NSInteger eggId; //5
	NSInteger eggImgId; //5
	NSString *eggName; //"\U30ab\U30e2\U306e\U305f\U307e\U3054"
	NSString *eggNameEN; //"mallard egg"
	NSInteger eggPrice; //22
	NSInteger emotion; //0
	NSInteger experience; //26
	NSString *farmId; //163D7A78682082B36872659C7A9DA8F9
	NSInteger farmType; //1
	NSInteger flyingSpeed; //45
	NSInteger flyingStep; //5
	NSInteger gender; //0
	NSInteger hatchTime; //14
	NSInteger health; //100
	NSString *lastFeedTime;
	NSInteger lastOutputTime; //1272292079
	NSInteger level; //29
	NSInteger levelRequired; //5
	NSInteger longevity; //0
	NSString *marriageDate;
	NSInteger originalAnimalId; //5
	NSString *picturePrefix; //mallard
	NSInteger productId; //5
	NSInteger productionFlag; //0
	// 生蛋剩余时间
	NSInteger remain;
	NSInteger runingSpeed; //30
	NSInteger runingStep; //3
	NSString *scientificNameCN; //"\U30ab\U30e2"
	NSString *scientificNameEN; //mallard
	NSString *sickStartTime;
	NSInteger speed; //30
	NSString *speedFlag; //?
	NSInteger stageEndTime; //28800
	NSInteger status; //0
	NSInteger step; //1
	NSInteger swimmingSpeed; //30
	NSInteger swimmingStep; //1
	NSString *virusReleaserId; //?
	NSInteger walkToEatSpeed; //30
	NSInteger walkToEatStep; //2
	NSInteger yield; //28
	NSInteger youthStage; //18
	NSInteger zygotePrice; //1161
}

@property (nonatomic,assign) NSInteger adultStage;
@property (nonatomic,assign) NSInteger aliveEdge;
//@property (nonatomic,assign) NSInteger animalName;
@property (nonatomic,retain) NSString *animalName;
@property (nonatomic,assign) NSInteger animalType;
@property (nonatomic,assign) NSInteger antsPrice;
@property (nonatomic,assign) NSInteger babyStage;
@property (nonatomic,assign) NSInteger baseCycle;
@property (nonatomic,assign) NSInteger baseInterval;
@property (nonatomic,assign) NSInteger basePrice;
@property (nonatomic,assign) NSInteger baseYield;
@property (nonatomic,assign) NSInteger birdStage;
@property (nonatomic,assign) NSInteger birdType;
@property (nonatomic,assign) NSInteger characteristic;
@property (nonatomic,assign) NSInteger coupleId;
@property (nonatomic,assign) NSInteger currentInterval;
@property (nonatomic,assign) NSInteger discount;
@property (nonatomic,assign) NSInteger eggId;
@property (nonatomic,assign) NSInteger eggImgId;
@property (nonatomic,assign) NSInteger eggPrice;
@property (nonatomic,assign) NSInteger emotion;
@property (nonatomic,assign) NSInteger experience;
@property (nonatomic,assign) NSInteger farmType;
@property (nonatomic,assign) NSInteger flyingSpeed;
@property (nonatomic,assign) NSInteger flyingStep;
@property (nonatomic,assign) NSInteger gender;
@property (nonatomic,assign) NSInteger hatchTime;
@property (nonatomic,assign) NSInteger health;
@property (nonatomic,assign) NSInteger lastOutputTime;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,assign) NSInteger levelRequired;
@property (nonatomic,assign) NSInteger longevity;
@property (nonatomic,assign) NSInteger originalAnimalId;
@property (nonatomic,assign) NSInteger productId;
@property (nonatomic,assign) NSInteger productionFlag;
@property (nonatomic,assign) NSInteger remain;
@property (nonatomic,assign) NSInteger runingSpeed;
@property (nonatomic,assign) NSInteger runingStep;
@property (nonatomic,assign) NSInteger speed;
@property (nonatomic,assign) NSInteger stageEndTime;
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,assign) NSInteger step;
@property (nonatomic,assign) NSInteger swimmingSpeed;
@property (nonatomic,assign) NSInteger swimmingStep;
@property (nonatomic,assign) NSInteger walkToEatSpeed;
@property (nonatomic,assign) NSInteger walkToEatStep;
@property (nonatomic,assign) NSInteger yield;
@property (nonatomic,assign) NSInteger youthStage;
@property (nonatomic,assign) NSInteger zygotePrice;


@property (nonatomic,retain) NSString *animalId;
@property (nonatomic,retain) NSString *birthday;
@property (nonatomic,retain) NSString *coupleAnimalId;
@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSString *eggDescription;
@property (nonatomic,retain) NSString *eggName;
@property (nonatomic,retain) NSString *eggNameEN;
@property (nonatomic,retain) NSString *farmId;
@property (nonatomic,retain) NSString *lastFeedTime;
@property (nonatomic,retain) NSString *marriageDate;
@property (nonatomic,retain) NSString *picturePrefix;
@property (nonatomic,retain) NSString *scientificNameCN;
@property (nonatomic,retain) NSString *scientificNameEN;
@property (nonatomic,retain) NSString *sickStartTime;
@property (nonatomic,retain) NSString *speedFlag;
@property (nonatomic,retain) NSString *virusReleaserId;

@end
