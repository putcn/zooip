//
//  DataModelStorageAnimal.m
//  zoo
//
//  Created by Gu Lei on 10-6-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataModelStorageAnimal.h"


@implementation DataModelStorageAnimal

@synthesize
adultBirdStorageId,
originalAnimalId,
amount;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[adultBirdStorageId release];
	[originalAnimalId release];
	
	[super dealloc];
}


@end
