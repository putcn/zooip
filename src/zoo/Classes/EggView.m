//
//  EggView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "EggView.h"
#import "GameMainScene.h"


@implementation EggView

-(id) init
{
	if ((self = [super init])) {
		[[GameMainScene sharedGameMainScene] addSpriteToStage:self z:4];
	}
	return self;
}

-(void) dealloc
{
	[[GameMainScene sharedGameMainScene] removeSpriteFromStage:self];
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end
