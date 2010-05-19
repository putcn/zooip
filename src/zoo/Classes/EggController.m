//
//  EggController.m
//  zoo
//
//  Created by Rainbow on 5/16/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "EggController.h"


@implementation EggController

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
		allEggs = [[NSMutableArray alloc] initWithCapacity:0];
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
		[allEggs addObject:eggView];
		
	}
}

-(void) clearEgg
{
	for (EggView *clearEgg in allEggs)
	{
		[allEggs removeObject:clearEgg];
		[clearEgg dealloc];
	}
}

@end
