//
//  DejectaView.h
//  zoo
//
//  Created by Rainbow on 5/10/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "cocos2d.h"
#import "OperationViewController.h"

CCTexture2D *dejecta;
CGRect rect;

@interface DejectaView : CCSprite<CCTargetedTouchDelegate> {
	NSString *dejectaId;
}
@property (nonatomic, retain)NSString *dejectaId;

-(id) initWithPosition:(CGPoint)pos;

-(CGPoint)countCoordinate: (CGPoint)clickPoint;
-(void) optAnimationPlay;
-(void) callServerController;
@end
