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

@interface DataEnvironment : NSObject {
	//getFarmerInfo
	NSInteger antsCurrency;
	NSString *farmerId;
	NSInteger snsUserId;
	NSInteger platformId;
	NSString *userName;
	NSString *userImg;
	NSInteger farmPref;
	NSInteger fighter;
	BOOL isNewUser;
	BOOL haveNewMessage;
	NSInteger goldenEgg;
	BOOL haveTurtle;
	
	//getFarmInfo
	NSString *farmId;
	NSInteger farm_level;
	NSInteger farm_experience;
	NSInteger farm_expGainPerDay;
	NSInteger farm_expGainTime;
	NSInteger farm_maxNumOfBirds;
	NSInteger farm_foodEndTime;
	NSInteger farm_remain;
	NSInteger farm_nextLevelExp;
	NSInteger farm_currentExp;
	NSInteger farm_topMaxNumOfBirds;
	
	DataModelFarmerInfo *playerFarmerInfo;
	DataModelFarmerInfo *friendFarmerInfo;
	DataModelFarmInfo *playerFarmInfo;
	DataModelFarmInfo *friendFarmInfo;
	
	//getAllBirdFarmAnimalInfo
	NSMutableArray *animalIDs;
	NSMutableDictionary *animals;
}
+ (DataEnvironment *)sharedDataEnvironment;
- (void)restore;

//getFarmerInfo
@property(nonatomic,assign) NSInteger antsCurrency;
@property(nonatomic,assign) NSInteger snsUserId;
@property(nonatomic,assign) NSInteger platformId;
@property(nonatomic,assign) NSInteger farmPref;
@property(nonatomic,assign) NSInteger fighter;
@property(nonatomic,assign) NSInteger goldenEgg;
@property(nonatomic,assign) BOOL isNewUser;
@property(nonatomic,assign) BOOL haveNewMessage;
@property(nonatomic,assign) BOOL haveTurtle;
@property(nonatomic,retain) NSString *farmerId;
@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *userImg;

//getFarmInfo
@property(nonatomic,retain) NSString *farmId;
@property(nonatomic,assign) NSInteger farm_level;
@property(nonatomic,assign) NSInteger farm_experience;
@property(nonatomic,assign) NSInteger farm_expGainPerDay;
@property(nonatomic,assign) NSInteger farm_expGainTime;
@property(nonatomic,assign) NSInteger farm_maxNumOfBirds;
@property(nonatomic,assign) NSInteger farm_foodEndTime;
@property(nonatomic,assign) NSInteger farm_remain;
@property(nonatomic,assign) NSInteger farm_nextLevelExp;
@property(nonatomic,assign) NSInteger farm_currentExp;
@property(nonatomic,assign) NSInteger farm_topMaxNumOfBirds;

//getAllBirdFarmAnimalInfo
@property(nonatomic,retain) NSMutableArray *animalIDs;
@property(nonatomic,retain) NSMutableDictionary *animals;

@property(nonatomic,retain) DataModelFarmerInfo *playerFarmerInfo;
@property(nonatomic,retain) DataModelFarmerInfo *friendFarmerInfo;
@property(nonatomic,retain) DataModelFarmInfo *playerFarmInfo;
@property(nonatomic,retain) DataModelFarmInfo *friendFarmInfo;

@end
