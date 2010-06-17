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
		
		playerUid = @"1177553155";
		friendUid = @"1122334455";
		pid = @"11";
		
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
		
		//TEST
		DataModelFriendInfo *friendInfo = [[DataModelFriendInfo alloc] init];
		friendInfo.userName = @"test1";
		friendInfo.uid = @"1177553155";
		friendInfo.tinyurl = @"http://www.google.com";
		friendInfo.farmId = @"ASDASASSADAASASQWEWQWEQWQWQWEWEWEQWQWEWEQWQA";
		friendInfo.farmerId = @"ASDASASSADAASASQWEWQWEQWQWQWEWEWEQWQWEWEQWQA";
		friendInfo.experience = 100;
		
		[friendInfos setValue:friendInfo forKey:@"1177553155"];
		
		DataModelFriendInfo *friendInfo_2 = [[DataModelFriendInfo alloc] init];
		friendInfo_2.userName = @"test2";
		friendInfo_2.uid = @"1166553155";
		friendInfo_2.tinyurl = @"http://www.google.com";
		friendInfo_2.farmId = @"ASDASASSADAASASQWEWQWEQWQWQWEWEWEQWQWEWEQWQA";
		friendInfo_2.farmerId = @"ASDASASSADAASASQWEWQWEQWQWQWEWEWEQWQWEWEQWQA";
		friendInfo_2.experience = 100;
		
		[friendInfos setValue:friendInfo_2 forKey:@"1166553155"];
		
		friendIDs = [[NSMutableArray alloc] init];
		[friendIDs addObject:@"1122334455"];
		[friendIDs addObject:@"1122554455"];
		[friendIDs addObject:@"1188334455"];
		[friendIDs addObject:@"1166553155"];
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

@end