//
//  BowlsView.h
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "OperationViewController.h"
#import "FeedAllAnimalController.h"
#import "ToReleaseAntsController.h"
CCTexture2D *bowls;
CGRect rect;

@interface BowlsView : CCSprite<CCTargetedTouchDelegate>
{
	FeedAllAnimalController *feedAllAnimalController;
	ToReleaseAntsController *relaseAntController;
}

-(id) initWithFoodEndTime : (double) foodEndTime;

-(void)update: (double) foodEndTime;

-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
