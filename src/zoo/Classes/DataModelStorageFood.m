//
//  DataModelStorageFood.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelStorageFood.h"


@implementation DataModelStorageFood

@synthesize
foodStorageId,
foodId,
numOfFood,
foodPower,
foodName,
foodImg;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[foodStorageId release];
	[foodId release];
	[foodName release];
	[foodImg release];
	
	[super dealloc];
}


@end
