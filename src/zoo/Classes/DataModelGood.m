//
//  DataModelGood.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelGood.h"


@implementation DataModelGood

@synthesize
goodsId,
goodsType,
goodsDuration,
currencyType,
goodsAntsPrice,
goodsGoldenPrice,
levelRequired,
capability1,
capability2,
goodsPicture,
goodsName,
goodsDescription;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[goodsId release];
	[capability1 release];
	[capability2 release];
	[goodsPicture release];
	[goodsName release];
	[goodsDescription release];
	
	[super dealloc];
}


@end
