//
//  GameMainScene.h
//  zoo
//
//  Created by Niu Darcy on 3/24/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "UILayer.h"
#import "ScaleControlLayer.h"
#import "DragControlLayer.h"

@interface GameMainScene : CCLayer
{
	CCSprite *baseContainer;
}

+(GameMainScene *) sharedGameMainScene;
+(id) scene;

-(void) addSpriteToStage:(CCSprite *) sprite z:(int) zIndex;
-(void) removeSpriteFromStage:(CCSprite *) sprite;

@end
