//
//  AntView.h
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Cocos2d.h"
#import "OperationViewController.h"
#import "KillAntsController.h"


@interface AntView : CCSprite <CCTargetedTouchDelegate>{
	NSDictionary *dirctions;
	CCAnimation *animation;
	NSString *antId;
	
	KillAntsController *killAntsController;
}

@property (nonatomic, retain)NSString *antId;

-(id) initWithID: (NSString *)sId;
-(void) update:(int)currDirectionValue status:(int)currStatusValue;

-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
