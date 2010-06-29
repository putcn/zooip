//
//  GameController.m
//  zoo
//
//  Created by Gu Lei on 10-4-27.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameController.h"


@implementation GameController

static GameController *_sharedGameController = nil;

+(GameController *)sharedGameController
{
	@synchronized([GameController class])
	{
		if (!_sharedGameController)
		{
			_sharedGameController = [[GameController alloc] init];
		}
		
		return _sharedGameController;
	}
	
	return nil;
}

-(void) initGame
{
	
}

// Add by Hunk on 2010-06-29
-(void)dealloc
{
	
	
	[super dealloc];
}



@end
