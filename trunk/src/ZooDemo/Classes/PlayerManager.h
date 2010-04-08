//
//  PlayerManager.h
//  ZooDemo
//
//  Created by Gu Lei on 10-4-7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Button.h"

@interface PlayerManager : CCSprite
{
	NSMutableArray *statusIconTextures;
	CCSprite *buttonContainer;
	CCSprite *statusIcon;
	int selectIndex;
}

-(void) addButton;
-(void) addStatusIconTexture;

@end
