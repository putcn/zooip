//
//  DataModelStorageEgg.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelStorageEgg.h"


@implementation DataModelStorageEgg

@synthesize
eggStorageId,
eggId,
eggName,
eggNameEN,
eggImgId,
eggDescription,
numOfProduct,
numOfStolen,
eggPrice;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[eggStorageId release];
	[eggId release];
	[eggName release];
	[eggNameEN release];
	[eggImgId release];
	[eggDescription release];
	
	[super dealloc];
}


@end
