//
//  DataModelDog.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-18.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelDog.h"


@implementation DataModelDog

@synthesize
farmerDogId,
goodsId,
probability,
loseGoldenEgg,
level,
status,
statusEndTime,
endTime,
goodsDuration,
speed,
step,
aliveEdge,
picturePrefix,
goodsPicture,
goodsName,
goodsDescription;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[farmerDogId release];
	[goodsId release];
	[statusEndTime release];
	[endTime release];
	[goodsDuration release];
	[picturePrefix release];
	[goodsPicture release];
	[goodsName release];
	[goodsDescription release];
	
	[super dealloc];
}


@end
