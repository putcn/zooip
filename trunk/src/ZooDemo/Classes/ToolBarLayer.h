//
//  ToolBarLayer.h
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-2.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ToolSprite.h"


@interface ToolBarLayer : CCLayer {
	
	// 工具
	NSMutableArray* toolSpriteArray;
	// 打开工具栏
	ToolSprite* openSprite;
	// 关闭
	ToolSprite* closeSprite;
	// 指针
	ToolSprite* pointerSprite;
	// 手
	ToolSprite* handSprite;
	// 药箱
	ToolSprite* medicineSprite;
	// 杀虫剂
	ToolSprite* spraySprite;
	// 捕蛇网
	ToolSprite* catchSnakeSprite;
	// 笤帚
	ToolSprite* broomSprite;
	// 喂食铃
	ToolSprite* ringSprite;
	
}

-(void) initTools;
-(ToolSprite*) createToolSprite:(NSString*) fileName indexInToolbar:(int) index;

@end
