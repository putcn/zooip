//
//  DataModelStorageZygoteEgg.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-20.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelStorageZygoteEgg.h"


@implementation DataModelStorageZygoteEgg

@synthesize
zygoteStorageId,
eggId,
originalAnimalId,
baseYield,
zygoteBirthday,
incubatingTime,
zygoteGender,
status,
eggName,
eggNameEN,
eggPrice;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[zygoteStorageId release];
	[eggId release];
	[originalAnimalId release];
	[eggName release];
	[eggNameEN release];
	[zygoteBirthday release];
	
	[super dealloc];
}


@end
