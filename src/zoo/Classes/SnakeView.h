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

@interface SnakeView : CCSprite<CCTargetedTouchDelegate> {
	NSString *snakeId;
}

@property (nonatomic, retain)NSString *snakeId;

-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
