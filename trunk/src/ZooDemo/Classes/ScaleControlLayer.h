//
//  ScaleControlLayer.h
//  ZooDemo
//
//  Created by Niu Darcy on 4/7/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"


@interface ScaleControlLayer : CCLayer <CCTargetedTouchDelegate>
{
	CGFloat dX;
	CGFloat dY;
	
	CCSprite *target;
}

-(id)initWithTarget:(CCSprite*) targetValue;

@end
