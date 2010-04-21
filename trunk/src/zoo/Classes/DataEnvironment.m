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
			goldenEgg,
		   haveTurtle;

@synthesize farmId,
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

@synthesize animals;

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
		self.platformId = 11;
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
	antsCurrency = 0;
	farmerId = nil;
	snsUserId = 0;
	platformId = 11;
	userName = nil;
	userImg = nil;
	farmPref = 0;
	fighter = 0;
	isNewUser = NO;
	haveNewMessage = NO;
	goldenEgg = 0;
	haveTurtle = NO;
	
	farmId = nil;
	farm_level = 0;
	farm_experience = 0;
	farm_expGainPerDay = 0;
	farm_expGainTime = 0;
	farm_maxNumOfBirds = 0;
	farm_foodEndTime = 0;
	farm_remain = 0;
	farm_nextLevelExp = 0;
	farm_currentExp = 0;
	farm_topMaxNumOfBirds = 0;
	
	animals = nil;
}

@end