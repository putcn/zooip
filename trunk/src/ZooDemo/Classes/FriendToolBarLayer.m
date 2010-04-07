//
//  FriendToolBarSprite.m
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-2.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "FriendToolBarLayer.h"


@implementation FriendToolBarLayer

-(id) init
{
	if (self = [super init]) {
	}
	return self;
}

-(void) initTools
{
	[super initTools];
	ToolSprite* snakeSprite = [self createToolSprite:@"蛇.png" indexInToolbar:2];
	ToolSprite* antSprite = [self createToolSprite:@"蚂蚁.png" indexInToolbar:3];
	ToolSprite* firecrackerSprite = [self createToolSprite:@"爆竹.png" indexInToolbar:4];
}

@end
