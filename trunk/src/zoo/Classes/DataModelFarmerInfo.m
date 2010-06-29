//
//  DataModelFarmerInfo.m
//  zoo
//
//  Created by Gu Lei on 10-5-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataModelFarmerInfo.h"


@implementation DataModelFarmerInfo

@synthesize antsCurrency,
farmerId,
snsUserId,
platformId,
userName,
userImg,
farmPref,
fighter,
isNewUser,
haveNewMessage,
level,
experience,
nextLevelExp,
goldenEgg,
haveTurtle;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[farmerId release];
	[userName release];
	[userImg release];
	
	[super dealloc];
}


@end
