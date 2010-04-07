//
//  BarLayer.h
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-2.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ToolBarLayer.h"
#import "ToolSprite.h"
#import "SelfToolBarLayer.h"
#import "SelfUserInfoSprite.h"
#import "FriendsListSprite.h"

@interface BarLayer : CCLayer {
	// 工具栏
	ToolBarLayer* toolbarLayer;
	// 右上角
	TouchableSprite* myZooSprite;
	TouchableSprite* shopSprite;
	TouchableSprite* storeSprite;
	// 显示好友列表
	TouchableSprite* showFriendsSprite;
}

@end
