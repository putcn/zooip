//
//  SelfToolBarSprite.m
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-2.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "SelfToolBarLayer.h"


@implementation SelfToolBarLayer

-(id) init
{
	if (self = [super init]) {
		
	}
	return self;
}

-(void) initTools
{
	[super initTools];
	ToolSprite* feedSprite = [self createToolSprite:@"饲料.png" indexInToolbar:1];
	ToolSprite* cageSprite = [self createToolSprite:@"鸟窝.png" indexInToolbar:3];
	ToolSprite* animalManagementSprite = [self createToolSprite:@"动物管理.png" indexInToolbar:4];
	ToolSprite* ExpendSprite = [self createToolSprite:@"扩容.png" indexInToolbar:5];	
}

@end
