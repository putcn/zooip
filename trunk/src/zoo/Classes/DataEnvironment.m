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

@synthesize departureCity,
			arrivalCity,
			departureDate,
			arrivalDate,
			isDoubleWay,
			isMultiStop,
			keyword,
			price,
			isUseMap,
			searchCondUpdated,
			searchCondOrder,
			searchCondFilterTakeoffTimeDict,
			searchCondFilterFlightCompanyDict,
			searchCondFilterTakeoffAirportDict,
			searchCondFilterStarDict,
			starValueDict,
			priceAry,
		selectedHotel,
            flightCode;

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
		
	} else if ( self = [super init] ) {
		sharedInst = self;
		[self restore];
		
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
	departureCity = nil;
	arrivalCity = nil;
	departureDate = nil;
	arrivalDate = nil;
	keyword = nil;
	price = 0;
	isUseMap = NO;
	isDoubleWay = NO;
	isMultiStop = NO;
	searchCondUpdated = NO;
	searchCondOrder = 0;
	searchCondFilterTakeoffTimeDict = nil;
	searchCondFilterFlightCompanyDict = nil;
	searchCondFilterTakeoffAirportDict = nil;
	flightCode = nil;
	priceAry = nil;
	starValueDict = nil;
	selectedHotel = nil;
}

@end