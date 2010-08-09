//
//  DataEnvironment.m
//  Qunar
//
//  Created by kevinhuang on 2/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataEnvironment.h"
#import "DataMOdelFriendInfo.h"


@implementation DataEnvironment

static DataEnvironment *sharedInst = nil;

@synthesize playerUid;
@synthesize friendUid;
@synthesize pid;
@synthesize animalIDs;
@synthesize animals,
eggs,
ants,
snakes,
dejectas,
dogs,
friendIDs,
friendInfos,
userTipses,
storageFoods,
storageEggs,
storageZygoteEggs,
originalAnimals,
foods,
goods,
storageAnimals,
storageAuctionAnimals;

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
		
		// Player UID
//		playerUid = @"248726533";//黄老邪
//		playerUid = @"248725655";
		playerUid = @"46565162";// Hunk
//		playerUid = @"160412891";//蒋紫薇

//		playerUid = @"248951837"; //renyingying
		
//		playerUid = @"221110752";
		// New test UID
//		playerUid = @"248951866";//actual
//		playerUid = @"248951866";//傅红雪
//		playerUid = @"73388409"; //lancy
		
		// Friend UID
//		friendUid = @"327535525";
		

		
		//Mixi:11, RenRen:5 
		pid = @"5";
		
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
		storageAnimals = [[NSMutableDictionary alloc] init];
		storageAuctionAnimals = [[NSMutableDictionary alloc] init];
		
		//self.playerFarmerInfo.platformId = 11;
		
		friendIDs = [[NSMutableArray alloc] init];
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
	friendIDs = nil;
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

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[playerUid release];
	[friendUid release];
	[pid release];
	[playerFarmerInfo release];
	[friendFarmerInfo release];
	[playerFarmInfo release];
	[friendFarmInfo release];
	[animalIDs release];
	[animals release];
	[eggs release];
	[snakes release];
	[ants release];
	[dejectas release];
	[dogs release];
	[friendIDs release];
	[friendInfos release];
	[userTipses release];
	[storageFoods release];
	[storageEggs release];
	[storageZygoteEggs release];
	[originalAnimals release];
	[foods release];
	[goods release];
	[storageAnimals release];
	[storageAuctionAnimals release];
	
	[super dealloc];
}



@end