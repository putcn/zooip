//
//  ScaleControlLayer.h
//  Zoo
//
//  Created by Niu Darcy on 4/21/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"


@interface ScaleControlLayer : CCLayer <CCTargetedTouchDelegate>
{
	CGFloat dX;
	CGFloat dY;
	
	CCSprite *target;
	
	BOOL isReset;
	BOOL isWidth;
}

-(id)initWithTarget:(CCSprite*) targetValue;

@end
