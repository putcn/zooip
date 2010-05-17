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
		eggs = [[NSMutableArray alloc] initWithCapacity:0];
		return self;
	}
	
	return nil;
}

-(void) addEggs:(NSMutableArray *)eggIds
{
	for (NSString *eggId in eggIds) {
		
	//	EggView *eggView = [EggViewFactory createEggViews:[DataEnvironment sharedDataEnvironment]];
//		eggView.position;
//		eggView.eggId;
	}
}

-(void) clearEgg
{
	
}

@end
