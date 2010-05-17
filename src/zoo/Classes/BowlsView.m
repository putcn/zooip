//
//  BowlsView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "BowlsView.h"

@implementation BowlsView

-(id) initWithFoodEndTime: (NSDate *) foodEndTime
{
	if ((self = [super init])) {
		if (foodEndTime) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_0.png" ofType:nil]]];
		}
		else if(foodEndTime) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_1.png" ofType:nil]]];
		}
		else if(foodEndTime) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_2.png" ofType:nil]]];
		}
		else if(foodEndTime) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_3.png" ofType:nil]]];
		}
	}
	CGRect rect = CGRectZero;
	rect.size = bowls.contentSize;
	[self setTexture: bowls];
	[self setTextureRect: rect];
	self.position = ccp(100,100);
	return self;
}

-(void) update:(NSDate *) foodEndTime
{
	if (foodEndTime) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_0.png" ofType:nil]]];
	}
	else if(foodEndTime) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_1.png" ofType:nil]]];
	}
	else if(foodEndTime) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_2.png" ofType:nil]]];
	}
	else if(foodEndTime) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_3.png" ofType:nil]]];
	}
	rect.size = bowls.contentSize;
	[self setTexture: bowls];
	[self setTextureRect: rect];
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
	int type = OPERATION_FEED_ALL;
	if (type == OPERATION_DEFAULT) {
		[self schedule:@selector(tick:) interval:4.0];
	}
	else if(type == OPERATION_FEED_ALL){
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"normal_food" setPosition:location];
	}
	else if(type == OPERATION_FEED_POWER){
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"power_food" setPosition:location];
	}
	else if(type == OPERATION_FEED_PRODUCT_YIELD)
	{
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"product_yield_food" setPosition:location];
	}
	else {
		return;
	}

}

-(void)callServerController
{
	
}

-(void) dealloc
{
	[super dealloc];
}
@end
