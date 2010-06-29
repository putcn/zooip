//
//  DataModelFarmInfo.m
//  zoo
//
//  Created by Gu Lei on 10-5-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataModelFarmInfo.h"


@implementation DataModelFarmInfo

@synthesize farmId,
farmerId,
farm_level,
farm_experience,
farm_expGainPerDay,
farm_expGainTime,
farm_maxNumOfBirds,
farm_foodEndTime,
farm_remain,
farm_nextLevelExp,
farm_currentExp,
farm_topMaxNumOfBirds;


// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[farmId release];
	[farmerId release];
	
	[super dealloc];
}


@end
