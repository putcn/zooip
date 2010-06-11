//
//  BowlsView.m
//  zoo
//
//  Created by Rainbow on 5/9/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "BowlsView.h"
#import "GameMainScene.h"

@implementation BowlsView

-(id) initWithFoodEndTime: (double) foodEndTime
{
	if ((self = [super init])) {
		feedAllAnimalController = [[FeedAllAnimalController alloc] init];
		relaseAntController = [[ToReleaseAntsController alloc] init];
		
		if (foodEndTime <= 0.0f) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_0.png" ofType:nil]]];
		}
		else if(foodEndTime <= 2160.0f ) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_1.png" ofType:nil]]];
		}
		else if(foodEndTime <= 4320.0f) {
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_2.png" ofType:nil]]];
		}
		else{
			bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_3.png" ofType:nil]]];
		}
	}
	CGRect rect = CGRectZero;
	rect.size = bowls.contentSize;
	[self setTexture: bowls];
	[self setTextureRect: rect];
	self.position = ccp(386,176);
	[[GameMainScene sharedGameMainScene] addSpriteToStage:self z:4];
	return self;
}

-(void) update:(double) foodEndTime
{
	if (foodEndTime <= 0.0f) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_0.png" ofType:nil]]];
	}
	else if(foodEndTime <= 2160.0f) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_1.png" ofType:nil]]];
	}
	else if(foodEndTime <= 4320.0f) {
		bowls = [[CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bowls_2.png" ofType:nil]]];
	}
	else{
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
	[self callServerController];
}

-(CGPoint)countCoordinate: (CGPoint)clickPoint
{
	return ccp(self.position.x + clickPoint.x - self.contentSize.width/2, self.position.y + clickPoint.y - self.contentSize.height/2);
}

-(void)optAnimationPlay
{
	int type = [[UIController sharedUIController] getOperation];
	//int type = [[UIController sharedUIController] getOperation];
	if (type == OPERATION_DEFAULT) {
		//[self schedule:@selector(tick:) interval:4.0];
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
	else if(type == OPERATION_RELEASE_ANTS)
	{
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"put_ant" setPosition:location];
	}
	else {
		return;
	}

}

-(void)callServerController
{
	int type = [[UIController sharedUIController] getOperation];
	//int type = [[UIController sharedUIController] getOperation];
	
	if(type == OPERATION_FEED_ALL)
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].playerFarmInfo.farmId,@"farmId",nil];
		[feedAllAnimalController execute:params];
	}
	else if(type == OPERATION_RELEASE_ANTS)
	{
		NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmerId,@"farmerId",
								[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmId,@"farmId",
								[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"releaserId", @"0",@"bodyguard",nil];	
		[relaseAntController execute:params];
	}
}

-(void) dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}
@end
