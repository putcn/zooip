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
		allSnakes = [[NSMutableArray alloc] initWithCapacity:0];
		return self;
	}
	
	return nil;
}

-(void) addSnakes:(NSArray *)snakeIds
{
	for (NSString *snId in snakeIds) {
		[[SnakeView alloc] initWithID:snId];
	}
}

-(void) clearSnakes
{
	for (SnakeView *clearSnake in allSnakes)
	{
		[allSnakes removeObject:clearSnake];
		[clearSnake dealloc];
	}
}


@end
