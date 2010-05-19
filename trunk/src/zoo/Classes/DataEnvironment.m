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

@synthesize animalIDs;
@synthesize animals,
eggs,
ants,
snakes,
dejectas,
dogs;

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
	animalIDs = nil;
	animals = nil;
	eggs = nil;
	ants = nil;
	snakes = nil;
	dejectas = nil;
	dogs = nil;
	playerFarmerInfo = nil;
	friendFarmerInfo = nil;
	playerFarmInfo = nil;
	friendFarmInfo = nil;
}

@end