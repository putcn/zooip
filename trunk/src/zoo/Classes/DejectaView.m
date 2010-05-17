//
//  DejectaView.m
//  zoo
//
//  Created by Rainbow on 5/10/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DejectaView.h"


@implementation DejectaView
@synthesize dejectaId;
-(id) initWithPosition: (CGPoint)pos
{
	if ((self = [super init])) {
		CCAnimation *animation = [CCAnimation animationWithName:@"animal" delay:0.4];
		for (int i = 1; i<=4; i++) {
			[animation addFrameWithFilename:[NSString stringWithFormat:@"dejecta_%02d",i]];
		}
		CCRepeatForever *repeatAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
		self.position = pos;
		[self runAction:repeatAction];
	}
	return self;
}

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width/2, -s.height/2, s.width, s.height);
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ( ![self containsTouchLocation:touch] || !self.visible ) return NO;
	self.scale = 1;
	return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self optAnimationPlay];
}

-(CGPoint)countCoordinate: (CGPoint)clickPoint
{
	return ccp(self.position.x + clickPoint.x - self.contentSize.width/2, self.position.y + clickPoint.y - self.contentSize.height/2);
}

-(void)optAnimationPlay
{
	int type = OPERATION_CLEAR_DEJECTA;
	if (type ==OPERATION_DEFAULT) {
		[self schedule:@selector(tick:) interval:4.0];
	}
	else 
		if(type == OPERATION_CLEAR_DEJECTA){
			CGPoint location = ccp(self.position.x, self.position.y);
			[[OperationViewController sharedOperationViewController] play:@"cleaning" setPosition:location];
		}
		else {
			return;
		}
	
}

-(void)callServerController
{
	
}

@end
