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
#import "PlayerInitWorkFlowController.h"
#import "LoadView.h"

@interface GameMainScene : CCLayer
{
	CCSprite *baseContainer;
	CCSprite *background;
	
	UILayer *uiLayer;
	LoadView *loadView;
}

+(GameMainScene *) sharedGameMainScene;
+(id) scene;

-(void) addSpriteToStage:(CCSprite *) sprite z:(int) zIndex;
-(void) removeSpriteFromStage:(CCSprite *) sprite;
-(void) addDialogToScreen:(CCSprite *)sprite z:(int) zIndex;
-(void) removeDialogFromScreen:(CCSprite *)sprite;
-(void) loading:(NSString *)info;
-(void) finishLoading;
-(void) updateUserInfo;
-(void) switchZoo:(NSString *)playerUid;
-(void) clearAll;

@end
