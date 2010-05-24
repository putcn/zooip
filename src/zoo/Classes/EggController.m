//
//  EggController.m
//  zoo
//
//  Created by Rainbow on 5/16/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "EggController.h"


@implementation EggController
@synthesize allEggs;
static EggController *_sharedEggController = nil;

+(EggController *) sharedEggController
{
	@synchronized([EggController class])
	{
		if (!_sharedEggController)
		{
			_sharedEggController = [[EggController alloc] init];
		}
		
		return _sharedEggController;
	}
	
	return nil;
}

-(id) init
{
	if ((self = [super init]))
	{
		allEggs = [[NSMutableDictionary alloc] initWithCapacity:0];
		return self;
	}
	
	return nil;
}

-(void) addEggs:(NSArray *)eggIds
{
	DataModelEgg *dataModelEgg;
	for (NSString *eId in eggIds) {
		dataModelEgg = (DataModelEgg *) [[DataEnvironment sharedDataEnvironment].eggs objectForKey:eId];
		EggView *eggView = [EggViewFactory createEggView:[dataModelEgg.eggId intValue]];
		NSString *coordinate =dataModelEgg.coordinate;
		NSRange rang = [coordinate rangeOfString:@","];
		int commaPos = rang.location;
		int coordinateX = [[coordinate substringToIndex:commaPos] intValue];
		int coordinateY = [[coordinate substringFromIndex:commaPos + 1] intValue];
		eggView.position = ccp(coordinateX,768 - coordinateY);
		eggView.eggId = dataModelEgg.birdEggId;
		[allEggs setObject:eggView forKey:eId];		
	}
}

-(void) removeEgg:(NSString *)eggId setExperience:(NSInteger)experience
{
	DataModelEgg *dataModelEgg;
	dataModelEgg = (DataModelEgg *) [[DataEnvironment sharedDataEnvironment].eggs objectForKey:eggId];
	NSInteger eggNum = dataModelEgg.remain;
	CGPoint eggPos = [(EggView *)[allEggs objectForKey:eggId] position];
	[[OperationEndView alloc] initWithExperience:experience setPosition: ccp(eggPos.x, eggPos.y+20) setNumber:eggNum];
	[[allEggs objectForKey:eggId] dealloc];
	
}

-(void) clearEgg
{
	for (NSString *clearEgg in [allEggs allKeys])
	{
		[[allEggs objectForKey:clearEgg] dealloc];
	}
}

@end
