//
//  GameMainScene.m
//  zoo
//
//  Created by Niu Darcy on 3/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "GameMainScene.h"


@implementation GameMainScene

static GameMainScene *_sharedGameMainScene = nil;

+ (GameMainScene *)sharedGameMainScene
{
	@synchronized([GameMainScene class])
	{
		if (!_sharedGameMainScene)
		{
			_sharedGameMainScene = [GameMainScene node];
		}
		
		return _sharedGameMainScene;
	}
	
	return nil;
}

+(id) scene
{
	CCScene *scene = [CCScene node];
	GameMainScene *layer = [GameMainScene sharedGameMainScene];
	[scene addChild: layer];
	
	return scene;
}

@end
