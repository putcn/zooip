//
//  SnakeController.m
//  zoo
//
//  Created by Rainbow on 5/19/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "SnakeController.h"


@implementation SnakeController
static SnakeController *_sharedSnakeController = nil;

+(SnakeController *) sharedSnakeController
{
	@synchronized([SnakeController class])
	{
		if (!_sharedSnakeController)
		{
			_sharedSnakeController = [[SnakeController alloc] init];
		}
		
		return _sharedSnakeController;
	}
	
	return nil;
}

-(id) init
{
	if ((self = [super init]))
	{
		allSnakes = [[NSMutableDictionary alloc] initWithCapacity:0];
		return self;
	}
	
	return nil;
}

-(void) addSnakes:(NSArray *)snakeIds
{
	for (NSString *snId in snakeIds) {
		SnakeView *snakeView = [[SnakeView alloc] initWithID:snId];
		[allSnakes setObject:snakeView forKey:snId];
	}
}

-(void) removeSnake:(NSString *)snakeId setExperience:(NSInteger)experience
{
	DataModelSnake *dataModelSnake;
	dataModelSnake = (DataModelSnake *) [[DataEnvironment sharedDataEnvironment].snakes objectForKey:snakeId];
	CGPoint snakePos = [(SnakeView *)[allSnakes objectForKey:snakeId] position];
	[[OperationEndView alloc] initWithExperience:experience setPosition: ccp(snakePos.x, snakePos.y+50) setNumber:0];
	SnakeView *snakeView = [allSnakes objectForKey:snakeId];
	[[GameMainScene sharedGameMainScene] removeSpriteFromStage:snakeView];
	[allSnakes objectForKey:snakeId];
	[allSnakes removeObjectForKey:snakeId];	
}

-(void) clearSnakes
{
	for (NSString *clearSnake in [allSnakes allKeys])
	{
		SnakeView *snakeView = [allSnakes objectForKey:clearSnake];
		[[GameMainScene sharedGameMainScene] removeSpriteFromStage:snakeView];
		[snakeView release];
		[allSnakes removeObjectForKey:clearSnake];
	}
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[allSnakes release];
	
	[super dealloc];
}


@end
