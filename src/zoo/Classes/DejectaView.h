//
//  DejectaView.h
//  zoo
//
//  Created by Rainbow on 5/10/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "OperationViewController.h"
#import "DataEnvironment.h"
#import "DataModelDejecta.h"
#import "ClearDejectaController.h"


@interface DejectaView : CCSprite<CCTargetedTouchDelegate> {
	NSString *dejectaId;	
	ClearDejectaController *clearDejectaController;
}
@property (nonatomic, retain)NSString *dejectaId;

-(id) initWithID: (NSString *)sId;
-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
