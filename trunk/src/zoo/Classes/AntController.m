//
//  AntController.m
//  zoo
//
//  Created by Rainbow on 5/19/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AntController.h"


@implementation AntController
static AntController *_sharedAntController = nil;

+(AntController *) sharedAntController
{
	@synchronized([AntController class])
	{
		if (!_sharedAntController)
		{
			_sharedAntController = [[AntController alloc] init];
		}
		
		return _sharedAntController;
	}
	
	return nil;
}

-(id) init
{
	if ((self = [super init]))
	{
		allAnts = [[NSMutableArray alloc] initWithCapacity:0];
		return self;
	}
	
	return nil;
}

-(void) addAnts:(NSArray *)antIds
{
	for (NSString *anId in antIds) {
		[[AntView alloc] initWithID:anId];	
	}
}

-(void) clearAnts
{
	for (AntView *clearAnt in allAnts)
	{
		[allAnts removeObject:clearAnt];
		[clearAnt dealloc];
	}
}

@end
