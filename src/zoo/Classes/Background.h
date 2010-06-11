//
//  Background.h
//  zoo
//
//  Created by Rainbow on 6/10/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToThrowFireworkController.h"
#import "ToReleaseAntsController.h"
#import "OperationViewController.h"
#import "cocos2d.h"


@interface Background : CCSprite <CCTargetedTouchDelegate> {
	ToThrowFireworkController *throwFireworkController;
	ToReleaseAntsController	*releaseAntsController;
	CGPoint click;
}
-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
