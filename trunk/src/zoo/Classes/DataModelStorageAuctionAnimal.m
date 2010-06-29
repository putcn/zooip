//
//  DataModelStorageAuctionAnimal.m
//  zoo
//
//  Created by Gu Lei on 10-6-4.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataModelStorageAuctionAnimal.h"


@implementation DataModelStorageAuctionAnimal

@synthesize
auctionBirdStorageId,
animalId,
originalAnimalId;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[auctionBirdStorageId release];
	[animalId release];
	[originalAnimalId release];
	
	[super dealloc];
}


@end
