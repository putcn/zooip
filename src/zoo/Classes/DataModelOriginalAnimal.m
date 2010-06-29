//
//  DataModelOriginalAnimal.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelOriginalAnimal.h"


@implementation DataModelOriginalAnimal

@synthesize
originalAnimalId,
scientificNameCN,
scientificNameEN,
hatchTime,
babyStage,
youthStage,
adultStage,
baseYield,
baseCycle,
baseInterval,
basePrice,
antsPrice,
productId,
levelRequired,
birdType,
picturePrefix,
aliveEdge,
step,
speed,
flyingStep,
flyingSpeed,
swimmingStep,
swimmingSpeed,
runingStep,
runingSpeed,
walkToEatStep,
walkToEatSpeed,
description;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[originalAnimalId release];
	[scientificNameCN release];
	[scientificNameEN release];
	[productId release];
	[picturePrefix release];
	[description release];
	
	[super dealloc];
}


@end
