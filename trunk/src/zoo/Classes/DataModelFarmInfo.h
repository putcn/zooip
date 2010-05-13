//
//  DataModelFarmInfo.h
//  zoo
//
//  Created by Gu Lei on 10-5-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataModelCommon.h"


@interface DataModelFarmInfo : DataModelCommon
{
	NSString *farmId;
	NSString *farmerId;
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
}

@property(nonatomic,retain) NSString *farmId;
@property(nonatomic,retain) NSString *farmerId;
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

@end
