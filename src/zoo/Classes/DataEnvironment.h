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
	DataModelFarmerInfo *playerFarmerInfo;
	DataModelFarmerInfo *friendFarmerInfo;
	DataModelFarmInfo *playerFarmInfo;
	DataModelFarmInfo *friendFarmInfo;
	
	NSMutableArray *animalIDs;
	NSMutableDictionary *animals;
	
	NSMutableDictionary* eggs;
}
+ (DataEnvironment *)sharedDataEnvironment;
- (void)restore;

//getAllBirdFarmAnimalInfo
@property(nonatomic,retain) NSMutableArray *animalIDs;
@property(nonatomic,retain) NSMutableDictionary *animals;
@property(nonatomic, retain) NSMutableDictionary* eggs;
@property(nonatomic,retain) DataModelFarmerInfo *playerFarmerInfo;
@property(nonatomic,retain) DataModelFarmerInfo *friendFarmerInfo;
@property(nonatomic,retain) DataModelFarmInfo *playerFarmInfo;
@property(nonatomic,retain) DataModelFarmInfo *friendFarmInfo;

@end
