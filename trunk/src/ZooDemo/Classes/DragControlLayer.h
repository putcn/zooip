//
//  DragControlLayer.h
//  ZooDemo
//
//  Created by Niu Darcy on 4/8/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"


@interface DragControlLayer : CCLayer
{
	CGFloat oX;
	CGFloat oY;
	
	CCSprite *target;
	
	BOOL isReset;
	NSInteger curTouchesNum;
}

-(id)initWithTarget:(CCSprite*) targetValue;

@end
