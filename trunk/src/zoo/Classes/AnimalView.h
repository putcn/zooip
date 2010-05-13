//
//  AnimalView.h
//  ZooDemo
//
//  Created by Niu Darcy on 4/2/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "AnimalToolTip.h"
#import "OperationViewController.h"
#import "UIController.h"

@interface AnimalView : CCSprite <CCTargetedTouchDelegate>
{	
	NSMutableDictionary *animationTable;
	NSDictionary *dirctions;
	NSDictionary *statuses;
	CCSprite *toolTip;
	NSString *animalId;
	OperationViewController *operationViewController;
	UIController *uiController;
}

@property (nonatomic, retain) NSString *animalId;

-(void) update:(int)currDirectionValue status:(int)currStatusValue;
-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end



