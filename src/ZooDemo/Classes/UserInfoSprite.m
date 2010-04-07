//
//  UserInfoSprite.m
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-2.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "UserInfoSprite.h"


@implementation UserInfoSprite

-(id) init
{
	if (self = [super init]) {
		CCSprite* photoSprite = [CCSprite spriteWithFile:@"Icon.png"];
		photoSprite.scale = 0.5;
		photoSprite.position = ccp(20, 0);
		[self addChild:photoSprite];
		CCLabel* nameLabel = [CCLabel labelWithString:@"E.D." fontName:@"Marker Felt" fontSize:15];
		nameLabel.position = ccp(50, 0);
		[self addChild:nameLabel];
		
		// TODO 经验应该是进度条
		CCLabel* expLabel = [CCLabel labelWithString:@"1931/2000" fontName:@"Marker Felt" fontSize:12];
		expLabel.position = ccp(90, 0);
		[self addChild:expLabel];
		
		CCLabel* levelLabel = [CCLabel labelWithString:@"10级" fontName:@"Marker Felt" fontSize:12];
		levelLabel.position = ccp(140, 0);
		[self addChild:levelLabel];
		
		CCLabel* animalNumLabel = [CCLabel labelWithString:@"动物数量：10" fontName:@"Marker Felt" fontSize:12];
		animalNumLabel.position = ccp(200, 0);
		[self addChild:animalNumLabel];
	}
	return self;
}

@end
