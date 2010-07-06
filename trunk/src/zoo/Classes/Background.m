//
//  Background.m
//  zoo
//
//  Created by Rainbow on 6/10/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Background.h"
#import "UIController.h"
#import "AnimalController.h"

@implementation Background

-(id) init
{
	if ((self = [super init])) {	
		CCTexture2D *eggImg = [ [CCTexture2D alloc] initWithImage: [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"bgimg.png" ofType:nil]]];
		CGRect rect = CGRectZero;
		rect.size = eggImg.contentSize;
		[self setTexture: eggImg];
		[self setTextureRect: rect];
		[eggImg release];
		throwFireworkController = [[ToThrowFireworkController alloc] init];		
		releaseAntsController = [[ToReleaseAntsController alloc] init];
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
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:60 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	int type = [[UIController sharedUIController] getOperation];
	if(type == OPERATION_RELEASE_ANTS || type == OPERATION_CALL || type == OPERATION_THROW_FIREWORK)
	{
		click = [self convertTouchToNodeSpaceAR:touch];
		return YES;
	}
	else {
		return NO;
	}

}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self callServerController];
	[self optAnimationPlay];
}

-(CGPoint)countCoordinate: (CGPoint)clickPoint
{
	return ccp(self.position.x + clickPoint.x - self.contentSize.width/2, self.position.y + clickPoint.y - self.contentSize.height/2);
}

-(void)optAnimationPlay
{
	int type = [[UIController sharedUIController] getOperation];
	if(type == OPERATION_THROW_FIREWORK){
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"firecracker" setPosition:location];
	}
	else if(type == OPERATION_RELEASE_ANTS)
	{
		CGPoint location = ccp(self.position.x, self.position.y);
		[[OperationViewController sharedOperationViewController] play:@"put_ant" setPosition:location];
	}
	else if (type == OPERATION_CALL)
	{
		[[AnimalController sharedAnimalController] gotoEat];
		
		//CGPoint location = [background convertTouchToNodeSpaceAR:touch];
		CGPoint location = ccp(326,186);
		[[OperationViewController sharedOperationViewController] play:@"summon" setPosition:location];
	}
	
	
	else {
		return;
	}
	
	
}

-(void)callServerController
{
	int type = [[UIController sharedUIController] getOperation];
	
	if(type == OPERATION_THROW_FIREWORK)
	{
	//	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"farmerId",
	//							self.eggId,@"birdEggId",nil];
	//	[throwFireworkController execute:params];
	}
	else if(type == OPERATION_RELEASE_ANTS)
	{
		//NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmerId,@"farmerId",
//								[DataEnvironment sharedDataEnvironment].friendFarmInfo.farmId,@"farmId",
//								[DataEnvironment sharedDataEnvironment].playerFarmerInfo.farmerId,@"releaserId", @"0",@"bodyguard",nil];
//		[releaseAntsController execute:params];
	}
}

-(void) dealloc
{
	// Add by Hunk on 2010-06-29
	[throwFireworkController release];
	[releaseAntsController release];
	
	[self removeAllChildrenWithCleanup:YES];
	[super dealloc];
}

@end
