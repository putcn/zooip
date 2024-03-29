//
//  GameMainScene.h
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"


@interface GameMainScene : CCLayer
{
	NSMutableArray *mySceneArray;
	NSMutableArray *friendSceneArray;
	NSMutableArray *myAnimalArray;
	NSMutableArray *friendAnimalArray;
	CCSprite *baseContainer;
	CCSprite *baseContainer1;
	CCSprite *background;
	CCSprite *tree;
	CCSprite *house;
	CCSprite *waterbox;
	CCSprite *background1;
	CCSprite *tree1;
	CCSprite *house1;
	CCSprite *waterbox1;
	CCSprite *egg1;
	CCSprite *egg2;
	CCSprite *egg3;
	CCSprite *egg4;
	CCSprite *egg5;
	CCSprite *egg6;
	CCSprite *egg7;
	CCSprite *egg8;
	CCSprite *egg9;
	CCSprite *egg10;
	CCSprite *pan;
	CCSprite *egg11;
	CCSprite *egg12;
	CCSprite *egg13;
	CCSprite *egg14;
	CCSprite *egg15;
	CCSprite *egg16;
	CCSprite *egg17;
	CCSprite *egg18;
	CCSprite *egg19;
	CCSprite *egg20;
	CCSprite *pan1;
}

+(GameMainScene *) sharedGameMainScene;
+(id) scene;

@end
