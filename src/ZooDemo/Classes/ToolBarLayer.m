//
//  ToolBarLayer.m
//  ZooDemo
//
//  Created by Zhou Shuyan on 10-4-2.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "ToolBarLayer.h"


@implementation ToolBarLayer

-(id) init
{
	if (self = [super init]) {
		self.isTouchEnabled = YES;
		toolSpriteArray = [NSMutableArray new];
		[self initTools];
		for (int i = 0; i < toolSpriteArray.count; i++) {
			CCSprite* sprite = [toolSpriteArray objectAtIndex: i];
			sprite.position = ccp(20 + 40 * i, 20);
		}
	}
	return self;
}

-(void) initTools
{
	pointerSprite = [self createToolSprite:@"箭头.png" indexInToolbar:0];
	handSprite = [self createToolSprite:@"拾取.png" indexInToolbar:1];
	medicineSprite = [self createToolSprite:@"医疗.png" indexInToolbar:2];
	spraySprite = [self createToolSprite:@"杀虫剂.png" indexInToolbar:3];
	catchSnakeSprite = [self createToolSprite:@"网.png" indexInToolbar:4];
	broomSprite = [self createToolSprite:@"清扫.png" indexInToolbar:5];
	ringSprite = [self createToolSprite:@"召唤.png" indexInToolbar:6];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
	if (touch) {
		CGPoint location = [touch locationInView: [touch view]];
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
		for (int i = 0; i < toolSpriteArray.count; i++) {
			ToolSprite* sprite = [toolSpriteArray objectAtIndex: i];
			CGRect myRect = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
			
			
			if(CGRectContainsPoint(myRect, convertedPoint)) {
				[sprite fireTouchBegan];
			}
		}
	}
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
	if (touch) {
		CGPoint location = [touch locationInView: [touch view]];
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
		for (int i = 0; i < toolSpriteArray.count; i++) {
			ToolSprite* sprite = [toolSpriteArray objectAtIndex: i];
			CGRect myRect = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
			
			
			if(CGRectContainsPoint(myRect, convertedPoint)) {
				[sprite fireTouchMovedIn];
			} else {
				[sprite fireTouchMovedOut];
			}

		}
		
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
	if (touch) {
		CGPoint location = [touch locationInView: [touch view]];
		CGPoint convertedPoint = [[CCDirector sharedDirector] convertToGL:location];
		for (int i = 0; i < toolSpriteArray.count; i++) {
			ToolSprite* sprite = [toolSpriteArray objectAtIndex: i];
			CGRect myRect = CGRectMake(sprite.position.x, sprite.position.y, sprite.contentSize.width, sprite.contentSize.height);
			
			
			if(CGRectContainsPoint(myRect, convertedPoint)) {
				[sprite fireTouchEnded];
			}
		}
	}
}


-(ToolSprite*) createToolSprite:(NSString*) fileName indexInToolbar:(int) index
{
	ToolSprite* sprite = [ToolSprite spriteWithFile: fileName];
	sprite.scale = 0.5;
	[self addChild:sprite];
	[toolSpriteArray insertObject:sprite atIndex:index];
	return sprite;
}


@end
