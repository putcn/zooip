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
		allAnts = [[NSMutableDictionary alloc] initWithCapacity:0];
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

-(void) removeAnt:(NSString *)antId setExperience:(NSInteger)experience
{
	DataModelAnt *dataModelAnt;
	dataModelAnt = (DataModelAnt *) [[DataEnvironment sharedDataEnvironment].ants objectForKey:antId];
	CGPoint antPos = [(AntView *)[allAnts objectForKey:antId] position];
	[[OperationEndView alloc] initWithExperience:experience setPosition: ccp(antPos.x, antPos.y+50) setNumber:0];
	[[allAnts objectForKey:antId] dealloc];
	[allAnts removeObjectForKey:antId];
}

-(void) clearAnts
{
	for (NSString *clearAnt in [allAnts allKeys])
	{
		[[allAnts objectForKey:clearAnt] dealloc];
		[allAnts removeObjectForKey:clearAnt];
	}
}

@end
