//
//  EggView.h
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"

#import "OperationViewController.h"

@interface EggView : CCSprite<CCTargetedTouchDelegate> {
	NSString *eggId;
}
@property (nonatomic, retain) NSString *eggId;
-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
