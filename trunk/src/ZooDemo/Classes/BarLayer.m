//
//  BarLayer.m
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-2.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "BarLayer.h"


@implementation BarLayer

-(id) init
{
	if (self = [super init]) {
		self.isTouchEnabled = YES;
		// 用户信息栏
		SelfUserInfoSprite* userInfoSprite = [SelfUserInfoSprite node];
		userInfoSprite.position = ccp(0, 310);
		[self addChild:userInfoSprite];
		// 右上角图标
		myZooSprite = [TouchableSprite spriteWithFile:@"我的动物园.png"];
		myZooSprite.scale = 0.5;
		myZooSprite.position = ccp(380, 300);
		[self addChild:myZooSprite];
		shopSprite = [TouchableSprite spriteWithFile:@"购物车.png"];
		shopSprite.scale = 0.5;
		shopSprite.position = ccp(420, 300);
		[self addChild:shopSprite];
		storeSprite = [TouchableSprite spriteWithFile:@"我的蛋窝.png"];
		storeSprite.scale = 0.5;
		storeSprite.position = ccp(460, 300);
		[self addChild:storeSprite];
		// 工具栏
		toolbarLayer = [SelfToolBarLayer node];
		toolbarLayer.position = ccp(0, 0);
		[self addChild:toolbarLayer];
		// 显示好友列表
		showFriendsSprite = [TouchableSprite spriteWithFile:@"friends.png"];
		showFriendsSprite.scale = 0.5;
		showFriendsSprite.position = ccp(470, 10);
		[self addChild:showFriendsSprite];
	}
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
	if (touch) {
		CGPoint location = [touch locationInView: [touch view]];
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
		NSArray* children = [self children];
		for (int i = 0; i < children.count; i++) {
			CCNode* node = [children objectAtIndex: i];
			if ([node class] == [TouchableSprite class]) {
				ToolSprite* sprite = (ToolSprite*) node;

				CGRect myRect = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
			
			
				if(CGRectContainsPoint(myRect, convertedPoint)) {
					[sprite fireTouchBegan];
				}
			}
		}
	}
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
	if (touch) {
		CGPoint location = [touch locationInView: [touch view]];
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
		NSArray* children = [self children];
		for (int i = 0; i < children.count; i++) {
			CCNode* node = [children objectAtIndex: i];
			if ([node class] == [TouchableSprite class]) {
				ToolSprite* sprite = (ToolSprite*) node;
				
				CGRect myRect = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
				
				
				if(CGRectContainsPoint(myRect, convertedPoint)) {
					[sprite fireTouchMovedIn];
				} else {
					[sprite fireTouchMovedOut];
				}

			}
		}
	}	
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch * touch = [touches anyObject];
	if (touch) {
		CGPoint location = [touch locationInView: [touch view]];
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
		NSArray* children = [self children];
		for (int i = 0; i < children.count; i++) {
			CCNode* node = [children objectAtIndex: i];
			if ([node class] == [TouchableSprite class]) {
				ToolSprite* sprite = (ToolSprite*) node;
				
				CGRect myRect = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
				
				
				if(CGRectContainsPoint(myRect, convertedPoint)) {
					[sprite fireTouchEnded];
					if (sprite == showFriendsSprite) {
						// TODO 显示好友列表
						
					}
				}
			}
		}
	}	
}



@end
