//
//  EggView.h
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"

#import "OperationViewController.h"
#import "PickEggToStorageController.h"
#import "StealEggsFromFarmController.h"
#import "ToReleaseSnakeController.h"


@interface EggView : CCSprite<CCTargetedTouchDelegate> {
	NSString *eggId;
	
	PickEggToStorageController *pickEggController;
	StealEggsFromFarmController *stealEggsController;
	ToReleaseSnakeController *releaseSnakeController;
}
@property (nonatomic, retain) NSString *eggId;
-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
