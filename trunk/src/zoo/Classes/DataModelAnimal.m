//
//  DataModelAnimal.m
//  zoo
//
//  Created by Darcy on 4/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataModelAnimal.h"


@implementation DataModelAnimal

@synthesize adultStage;
@synthesize aliveEdge;
@synthesize animalName;
@synthesize animalType;
@synthesize antsPrice;
@synthesize babyStage;
@synthesize baseCycle;
@synthesize baseInterval;
@synthesize basePrice;
@synthesize baseYield;
@synthesize birdStage;
@synthesize birdType;
@synthesize characteristic;
@synthesize coupleId;
@synthesize currentInterval;
@synthesize discount;
@synthesize eggId;
@synthesize eggImgId;
@synthesize eggPrice;
@synthesize emotion;
@synthesize experience;
@synthesize farmType;
@synthesize flyingSpeed;
@synthesize flyingStep;
@synthesize gender;
@synthesize hatchTime;
@synthesize health;
@synthesize lastOutputTime;
@synthesize level;
@synthesize levelRequired;
@synthesize longevity;
@synthesize originalAnimalId;
@synthesize productId;
@synthesize productionFlag;
@synthesize remain;
@synthesize runingSpeed;
@synthesize runingStep;
@synthesize speed;
@synthesize stageEndTime;
@synthesize status;
@synthesize step;
@synthesize swimmingSpeed;
@synthesize swimmingStep;
@synthesize walkToEatSpeed;
@synthesize walkToEatStep;
@synthesize yield;
@synthesize youthStage;
@synthesize zygotePrice;


@synthesize animalId;
@synthesize birthday;
@synthesize coupleAnimalId;
@synthesize description;
@synthesize eggDescription;
@synthesize eggName;
@synthesize eggNameEN;
@synthesize farmId;
@synthesize lastFeedTime;
@synthesize marriageDate;
@synthesize picturePrefix;
@synthesize scientificNameCN;
@synthesize scientificNameEN;
@synthesize sickStartTime;
@synthesize speedFlag;
@synthesize virusReleaserId;


// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[animalName release];
	[animalId release];
	[birthday release];
	[description release];
	[eggDescription release];
	[eggName release];
	[eggNameEN release];
	[farmId release];
	[lastFeedTime release];
	[marriageDate release];
	[picturePrefix release];
	[scientificNameCN release];
	[scientificNameEN release];
	[sickStartTime release];
	[speedFlag release];
	[virusReleaserId release];
	
	[super dealloc];
}


@end
