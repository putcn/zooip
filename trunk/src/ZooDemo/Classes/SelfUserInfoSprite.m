//
//  SelfUserInfoSprite.m
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-5.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "SelfUserInfoSprite.h"


@implementation SelfUserInfoSprite

-(id) init
{
	if (self = [super init]) {		
		CCSprite* goldSprite = [CCSprite spriteWithFile:@"金蛋.png"];
		goldSprite.scale = 0.5;
		goldSprite.position = ccp(250, 0);
		[self addChild:goldSprite];
		CCLabel* goldLabel = [CCLabel labelWithString:@"3478" fontName:@"Marker Felt" fontSize:12];
		goldLabel.position = ccp(275, 0);
		[self addChild:goldLabel];
		
		CCSprite* goldAntSprite = [CCSprite spriteWithFile:@"金蚂蚁.png"];
		goldAntSprite.scale = 0.5;
		goldAntSprite.position = ccp(300, 0);
		[self addChild:goldAntSprite];
		CCLabel* goldAntLabel = [CCLabel labelWithString:@"98" fontName:@"Marker Felt" fontSize:12];
		goldAntLabel.position = ccp(320, 0);
		[self addChild:goldAntLabel];
	}
	return self;
}

@end
