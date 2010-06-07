//
//  DejectaController.m
//  zoo
//
//  Created by Rainbow on 5/19/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DejectaController.h"


@implementation DejectaController
@synthesize allDejectas;

static DejectaController *_sharedDejectaController = nil;

+(DejectaController *) sharedDejectaController
{
	@synchronized([DejectaController class])
	{
		if (!_sharedDejectaController)
		{
			_sharedDejectaController = [[DejectaController alloc] init];
		}
		
		return _sharedDejectaController;
	}
	
	return nil;
}

-(id) init
{
	if ((self = [super init]))
	{
		allDejectas = [[NSMutableDictionary alloc] initWithCapacity:0];
		return self;
	}
	
	return nil;
}

-(void) addDejectas:(NSArray *)dejectaIds
{
	for (NSString *deId in dejectaIds) {
		DejectaView *dejectaView = [[DejectaView alloc] initWithID:deId];
		[allDejectas setObject:dejectaView forKey:deId];
	}
}

-(void) removeDejecta:(NSString *)dejectaId setExperience:(NSInteger)experience
{
	DataModelDejecta *dataModelDejecta;
	dataModelDejecta = (DataModelDejecta *) [[DataEnvironment sharedDataEnvironment].dejectas objectForKey:dejectaId];
	
	CGPoint dejectaPos = [(DejectaView *)[allDejectas objectForKey:dejectaId] position];
	[[OperationEndView alloc] initWithExperience:experience setPosition: ccp(dejectaPos.x, dejectaPos.y+50) setNumber:0];
	DejectaView *dejectaView = [allDejectas objectForKey:dejectaId];
	[[GameMainScene sharedGameMainScene] removeSpriteFromStage:dejectaView];
	[[allDejectas objectForKey:dejectaId] release];
	[allDejectas removeObjectForKey:dejectaId];
}

-(void) clearDejectas
{
	for (NSString *clearDejecta in [allDejectas allKeys])
	{
		DejectaView *dejectaView = [allDejectas objectForKey:clearDejecta];
		[[GameMainScene sharedGameMainScene] removeSpriteFromStage:dejectaView];
		[dejectaView release];
		[allDejectas removeObjectForKey:clearDejecta];
	}
}

@end
