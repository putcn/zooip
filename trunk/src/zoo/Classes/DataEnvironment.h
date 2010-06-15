//
//  DataEnvironment.h
//  Qunar
//
//  Created by kevinhuang on 2/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModelFarmerInfo.h"
#import "DataModelFarmInfo.h"

@interface DataEnvironment : NSObject
{
	NSString *playerUid;
	NSString *friendUid;
	NSString *pid;
	
	DataModelFarmerInfo *playerFarmerInfo;
	DataModelFarmerInfo *friendFarmerInfo;
	DataModelFarmInfo *playerFarmInfo;
	DataModelFarmInfo *friendFarmInfo;
	
	NSMutableArray *animalIDs;
	NSMutableDictionary *animals;
	
	NSMutableDictionary* eggs;
	NSMutableDictionary* snakes;
	NSMutableDictionary* ants;
	NSMutableDictionary* dejectas;
	NSMutableDictionary* dogs;
	NSMutableArray *friendIDs;
	NSMutableDictionary* friendInfos;
	NSMutableDictionary* userTipses;
	NSMutableDictionary* storageFoods;
	NSMutableDictionary* storageEggs;
	NSMutableDictionary* storageZygoteEggs;
	NSMutableDictionary* originalAnimals;
	NSMutableDictionary* foods;
	NSMutableDictionary* goods;
	NSMutableDictionary* storageAnimals;
	NSMutableDictionary* storageAuctionAnimals;
}
+ (DataEnvironment *)sharedDataEnvironment;
- (void)restore;

@property(nonatomic,retain) NSString* playerUid;
@property(nonatomic,retain) NSString* friendUid;
@property(nonatomic,retain) NSString* pid;
//getAllBirdFarmAnimalInfo
@property(nonatomic,retain) NSMutableArray *animalIDs;
@property(nonatomic,retain) NSMutableDictionary *animals;
@property(nonatomic, retain) NSMutableDictionary* eggs;
@property(nonatomic, retain) NSMutableDictionary* snakes;
@property(nonatomic, retain) NSMutableDictionary* ants;
@property(nonatomic, retain) NSMutableDictionary* dejectas;
@property(nonatomic, retain) NSMutableDictionary* dogs;
@property(nonatomic, retain) NSMutableArray* friendIDs;
@property(nonatomic, retain) NSMutableDictionary* friendInfos;
@property(nonatomic, retain) NSMutableDictionary* userTipses;
@property(nonatomic, retain) NSMutableDictionary* storageFoods;
@property(nonatomic, retain) NSMutableDictionary* storageEggs;
@property(nonatomic, retain) NSMutableDictionary* storageZygoteEggs;
@property(nonatomic, retain) NSMutableDictionary* originalAnimals;
@property(nonatomic, retain) NSMutableDictionary* foods;
@property(nonatomic, retain) NSMutableDictionary* goods;
@property(nonatomic, retain) NSMutableDictionary* storageAnimals;
@property(nonatomic, retain) NSMutableDictionary* storageAuctionAnimals;

@property(nonatomic,retain) DataModelFarmerInfo *playerFarmerInfo;
@property(nonatomic,retain) DataModelFarmerInfo *friendFarmerInfo;
@property(nonatomic,retain) DataModelFarmInfo *playerFarmInfo;
@property(nonatomic,retain) DataModelFarmInfo *friendFarmInfo;

@end
