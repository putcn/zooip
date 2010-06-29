//
//  DataModelFood.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelFood.h"


@implementation DataModelFood

@synthesize
foodId,
foodPower,
foodName,
foodPrice,
antsRequired,
foodImg;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[foodId release];
	[foodPower release];
	[foodName release];
	[foodImg release];
	
	[super dealloc];
}


@end
