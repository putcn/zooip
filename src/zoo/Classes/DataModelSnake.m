//
//  DataModelSnake.m
//  zoo
//
//  Created by Zhou Shuyan on 10-5-18.
//  Copyright 2010 VIT. All rights reserved.
//

#import "DataModelSnake.h"


@implementation DataModelSnake

@synthesize
releaseSnakeId,
snakeReleaser,
eggId;

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	[releaseSnakeId release];
	[snakeReleaser release];
	[eggId release];
	
	[super dealloc];
}


@end
