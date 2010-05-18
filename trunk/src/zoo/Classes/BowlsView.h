//
//  BowlsView.h
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "OperationViewController.h"
CCTexture2D *bowls;
CGRect rect;

@interface BowlsView : CCSprite<CCTargetedTouchDelegate> {
	
}

-(id) initWithFoodEndTime : (NSDate *) foodEndTime;

-(void)update: (NSDate *) foodEndTime;

-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end