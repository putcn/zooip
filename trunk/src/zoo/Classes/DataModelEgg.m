//
//  DataModelEgg.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-16.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelEgg.h"


@implementation DataModelEgg

@synthesize
	birdEggId,
	farmId,
	quantity,
	remain,
	lastStoleTime,
	numOfZygote,
	coordinate,
	eggId,
	eggName,
	eggNameEN,
	eggPrice,
	zygotePrice,
	eggImgId,
	eggDescription;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[birdEggId release];
	[farmId release];
	[lastStoleTime release];
	[coordinate release];
	[eggId release];
	[eggName release];
	[eggNameEN release];
	[eggImgId release];
	[eggDescription release];
	
	[super dealloc];
}


@end
