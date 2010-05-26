//
//  DataEnvironment.m
//  Qunar
//
//  Created by kevinhuang on 2/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataEnvironment.h"


@implementation DataEnvironment

static DataEnvironment *sharedInst = nil;

@synthesize playerUid;
@synthesize animalIDs;
@synthesize animals,
eggs,
ants,
snakes,
dejectas,
dogs,
friendInfos,
userTipses,
storageFoods,
storageEggs,
storageZygoteEggs,
originalAnimals,
foods,
goods;

@synthesize playerFarmerInfo;
@synthesize friendFarmerInfo;
@synthesize playerFarmInfo;
@synthesize friendFarmInfo;

+ (id)sharedDataEnvironment{
    @synchronized( self ) {
        if ( sharedInst == nil ) {
            /* sharedInst set up in init */
			
            [[self alloc] init];
			
        }
    }
	
    return sharedInst;
}

- (id)init{
    if ( sharedInst != nil ) {
		
	} else if ( (self = [super init]) ) {
		sharedInst = self;
		[self restore];
		
		playerUid = @"1122334455";
		
		playerFarmerInfo = [[DataModelFarmerInfo alloc] init];
		friendFarmerInfo = [[DataModelFarmerInfo alloc] init];
		playerFarmInfo = [[DataModelFarmInfo alloc] init];
		friendFarmInfo = [[DataModelFarmInfo alloc] init];
		
		animals = [[NSMutableDictionary alloc] init];
		animalIDs = [[NSMutableArray alloc] init];
		eggs = [[NSMutableDictionary alloc] init];
		ants = [[NSMutableDictionary alloc] init];
		snakes = [[NSMutableDictionary alloc] init];
		dejectas = [[NSMutableDictionary alloc] init];
		dogs = [[NSMutableDictionary alloc] init];
		friendInfos = [[NSMutableDictionary alloc] init];
		userTipses = [[NSMutableDictionary alloc] init];
		storageFoods = [[NSMutableDictionary alloc] init];
		storageEggs = [[NSMutableDictionary alloc] init];
		storageZygoteEggs = [[NSMutableDictionary alloc] init];
		originalAnimals = [[NSMutableDictionary alloc] init];
		foods = [[NSMutableDictionary alloc] init];
		goods = [[NSMutableDictionary alloc] init];
		
		self.playerFarmerInfo.platformId = 11;
	}
	return sharedInst;
}

- (NSUInteger)retainCount{
	return NSUIntegerMax;
}

- (oneway void)release{
}

- (id)retain{
	return sharedInst;
}

- (id)autorelease{
	return sharedInst;
}

- (void)restore{
	playerUid = nil;
	animalIDs = nil;
	animals = nil;
	eggs = nil;
	ants = nil;
	snakes = nil;
	dejectas = nil;
	dogs = nil;
	friendInfos = nil;
	userTipses = nil;
	storageFoods = nil;
	storageEggs = nil;
	storageZygoteEggs = nil;
	originalAnimals = nil;
	foods = nil;
	goods =nil;
	
	playerFarmerInfo = nil;
	friendFarmerInfo = nil;
	playerFarmInfo = nil;
	friendFarmInfo = nil;
}

@end