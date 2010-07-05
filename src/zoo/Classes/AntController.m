//
//  AntController.m
//  zoo
//
//  Created by Rainbow on 5/19/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "AntController.h"
#import "FarmAnimal.h"


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
		AntView * antView = [[AntView alloc] initWithID:anId];
		[[FarmAnimal alloc] initWithView:antView setSpeed:0.5f setLimitRect:CGRectMake(300, 100, 100, 100)];
		[allAnts setObject:antView forKey:anId];
	}
}

-(void) removeAnt:(NSString *)antId setExperience:(NSInteger)experience
{
	DataModelAnt *dataModelAnt;
	dataModelAnt = (DataModelAnt *) [[DataEnvironment sharedDataEnvironment].ants objectForKey:antId];
	CGPoint antPos = [(AntView *)[allAnts objectForKey:antId] position];
	[[OperationEndView alloc] initWithExperience:experience setPosition: ccp(antPos.x, antPos.y+50) setNumber:0];
	AntView *antView = [allAnts objectForKey:antId];
	[[GameMainScene sharedGameMainScene] removeSpriteFromStage:antView];
	[antView release];
	[allAnts removeObjectForKey:antId];
}

-(void) clearAnts
{
	for (NSString *clearAnt in [allAnts allKeys])
	{
		AntView *antView = [allAnts objectForKey:clearAnt];
		[[GameMainScene sharedGameMainScene] removeSpriteFromStage:antView];
		[antView release];
		[allAnts removeObjectForKey:clearAnt];
	}
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[allAnts release];
	
	[super dealloc];
}


@end
