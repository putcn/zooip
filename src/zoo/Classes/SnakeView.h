//
//  SnakeView.h
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "OperationViewController.h"
#import "DataModelSnake.h"
#import "DataEnvironment.h"
#import "EggController.h"
#import "EggView.h"
#import "KillSnakeController.h"

@interface SnakeView : CCSprite<CCTargetedTouchDelegate> {
	NSString *snakeId;
	
	KillSnakeController *killSnakeController;
}

@property (nonatomic, retain)NSString *snakeId;
-(id) initWithID: (NSString *)sId;
-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
